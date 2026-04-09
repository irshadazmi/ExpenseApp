# backend-api/app/core/database.py
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
from sqlalchemy.orm import sessionmaker
from app.core.config import settings
from typing import AsyncGenerator

# -------------------------------------------------------------------
# DATABASE URL
# -------------------------------------------------------------------
DATABASE_URL = (
    f"postgresql+asyncpg://{settings.DB_USER}:{settings.DB_PASSWORD}"
    f"@{settings.DB_HOST}:{settings.DB_PORT}/{settings.DB_NAME}"
)

# -------------------------------------------------------------------
# ENGINE
# -------------------------------------------------------------------
engine = create_async_engine(
    DATABASE_URL,
    echo=True,              # Set False in production
    future=True,
    pool_pre_ping=True,     # Avoid stale connections
)

# -------------------------------------------------------------------
# SESSION FACTORY
# -------------------------------------------------------------------
async_session = sessionmaker(
    bind=engine,
    class_=AsyncSession,
    expire_on_commit=False,
    autoflush=False,
    autocommit=False,
)

# -------------------------------------------------------------------
# DB DEPENDENCY (FASTAPI)
# -------------------------------------------------------------------
async def get_db() -> AsyncGenerator[AsyncSession, None]:
    async with async_session() as session:
        try:
            yield session

        except Exception as e:
            print("❌ DB SESSION ERROR:", str(e))
            await session.rollback()   # 🔥 CRITICAL
            raise e

        finally:
            await session.close()


# -------------------------------------------------------------------
# OPTIONAL: GENERIC SAFE EXECUTOR (RECOMMENDED)
# -------------------------------------------------------------------
async def execute_safe(db: AsyncSession, func):
    try:
        result = await func()
        await db.commit()
        return result

    except Exception as e:
        print("❌ EXECUTE SAFE ERROR:", str(e))
        await db.rollback()
        raise e


# -------------------------------------------------------------------
# OPTIONAL: CONTEXT MANAGER (ADVANCED / CLEAN ARCHITECTURE)
# -------------------------------------------------------------------
class DBSessionManager:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def __aenter__(self):
        return self.session

    async def __aexit__(self, exc_type, exc, tb):
        if exc:
            await self.session.rollback()
        else:
            await self.session.commit()

        await self.session.close()

# # Updated to include SSL requirement for remote database connection
# from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine
# from sqlalchemy.orm import sessionmaker
# from app.core.config import settings

# DATABASE_URL = (
#     f"postgresql+asyncpg://{settings.DB_USER}:{settings.DB_PASSWORD}"
#     f"@{settings.DB_HOST}:{settings.DB_PORT}/{settings.DB_NAME}?ssl=require"
# )

# engine = create_async_engine(DATABASE_URL, echo=True)
# async_session = sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)

# async def get_db():
#     async with async_session() as session:
#         yield session