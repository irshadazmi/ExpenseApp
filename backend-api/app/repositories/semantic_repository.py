# app/repositories/semantic_repository.py

from typing import Any, Dict, List, Optional
import json
from datetime import datetime, date

from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text


# -------------------------------------------------------
# SAFE JSON SERIALIZER (Fixes datetime, Decimal, etc.)
# -------------------------------------------------------
def json_safe(obj):
    """Convert non-serializable values into safe JSON."""
    if isinstance(obj, dict):
        return {k: json_safe(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [json_safe(v) for v in obj]
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    return obj


class SemanticRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    # -------------------------------------------------------
    # UPSERT semantic cache entry
    # -------------------------------------------------------
    async def upsert_cache(
        self,
        user_id: int,
        cache_key: str,
        query_text: str,
        embedding: List[float],
        response_obj: Dict[str, Any],
    ) -> None:

        dims = len(embedding)
        emb_literal = "ARRAY[" + ",".join(map(str, embedding)) + f"]::vector({dims})"

        # Convert metadata into JSON-safe before saving
        safe_metadata = json.dumps(json_safe(response_obj))

        sql = text(f"""
            INSERT INTO semantic_cache (
                user_id,
                cache_key,
                query_text,
                embedding,
                metadata,
                created_at,
                updated_at
            )
            VALUES (
                :user_id,
                :cache_key,
                :query_text,
                {emb_literal},
                :metadata,
                NOW(),
                NOW()
            )
            ON CONFLICT (user_id, cache_key)
            DO UPDATE SET
                query_text = EXCLUDED.query_text,
                embedding  = EXCLUDED.embedding,
                metadata   = EXCLUDED.metadata,
                updated_at = NOW();
        """)

        await self.db.execute(sql, {
            "user_id": user_id,
            "cache_key": cache_key,
            "query_text": query_text,
            "metadata": safe_metadata,
        })

        await self.db.commit()

    # -------------------------------------------------------
    # VECTOR SEARCH using PGVector ANN index
    # -------------------------------------------------------
    async def search_similar(
        self,
        embedding: List[float],
        limit: int = 3
    ) -> List[Dict[str, Any]]:

        dims = len(embedding)
        emb_literal = "ARRAY[" + ",".join(map(str, embedding)) + f"]::vector({dims})"

        sql = text(f"""
            SELECT
                id,
                user_id,
                cache_key,
                query_text,
                metadata,
                embedding <=> {emb_literal} AS distance
            FROM semantic_cache
            ORDER BY distance
            LIMIT :limit;
        """)

        result = await self.db.execute(sql, {"limit": limit})
        rows = [dict(r) for r in result.mappings().all()]

        # Decode metadata safely
        for r in rows:
            if isinstance(r.get("metadata"), (str, bytes)):
                try:
                    r["metadata"] = json.loads(r["metadata"])
                except:
                    pass

        return rows

    # -------------------------------------------------------
    # Exact cache key lookup (if needed)
    # -------------------------------------------------------
    async def get_by_cache_key(
        self, user_id: int, cache_key: str
    ) -> Optional[Dict[str, Any]]:

        sql = text("""
            SELECT
                id,
                user_id,
                cache_key,
                query_text,
                metadata,
                created_at,
                updated_at
            FROM semantic_cache
            WHERE user_id = :user_id
              AND cache_key = :cache_key
            LIMIT 1;
        """)

        row = await self.db.execute(sql, {
            "user_id": user_id,
            "cache_key": cache_key
        })

        row = row.mappings().first()
        if not row:
            return None

        data = dict(row)

        # Decode metadata
        if isinstance(data.get("metadata"), (str, bytes)):
            try:
                data["metadata"] = json.loads(data["metadata"])
            except:
                pass

        return data
