from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    # ==================================================
    # CORE APP
    # ==================================================
    APP_NAME: str

    DB_HOST: str
    DB_PORT: str
    DB_NAME: str
    DB_USER: str
    DB_PASSWORD: str

    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

    # ==================================================
    # AI / LLM CONFIG
    # ==================================================
    USE_OLLAMA: bool = False        # true = primary LLM via Ollama
    OLLAMA_BASE_URL: str | None = None
    OLLAMA_MODEL: str = "llama3"

    OPENAI_API_KEY: str | None = None
    OPENAI_MODEL: str = "gpt-4o-mini"

    LLM_TIMEOUT_SECONDS: int = 60


    # ==================================================
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
