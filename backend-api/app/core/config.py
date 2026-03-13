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
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
