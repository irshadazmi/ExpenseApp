# backend-api/app/utils/llm_client.py
import httpx
import re
from app.core.config import settings

BASE_URL = settings.OLLAMA_BASE_URL or "http://localhost:11434"
MODEL = settings.OLLAMA_MODEL
TIMEOUT = 60


def clean_sql(text: str) -> str:
    text = re.sub(r"```sql", "", text, flags=re.IGNORECASE)
    text = re.sub(r"```", "", text)
    return text.strip()


async def ask_llm(prompt: str) -> str:
    async with httpx.AsyncClient(timeout=TIMEOUT) as client:
        resp = await client.post(
            f"{BASE_URL}/api/generate",
            json={
                "model": MODEL,
                "prompt": prompt,
                "stream": False,
            },
        )

    resp.raise_for_status()

    data = resp.json()
    return clean_sql(data.get("response", ""))
