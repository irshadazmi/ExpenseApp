CREATE EXTENSION IF NOT EXISTS vector;

-- embedding dimension for nomic-embed-text = 768
CREATE TABLE IF NOT EXISTS semantic_cache (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  cache_key TEXT NOT NULL,
  query_text TEXT,
  embedding vector(768),
  metadata JSONB,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS semantic_cache_user_key_idx
  ON semantic_cache (user_id, cache_key);

CREATE INDEX IF NOT EXISTS semantic_cache_hnsw_idx
  ON semantic_cache USING hnsw (embedding vector_cosine_ops)
  WITH (m = 16, ef_construction = 200);
