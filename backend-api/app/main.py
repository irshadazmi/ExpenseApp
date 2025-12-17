# backend-api/app/main.py
from fastapi import FastAPI
from app.middlewares import auth_middleware
from app.middlewares.cors_middleware import add_cors_middleware
from app.routers.auth_router import auth_router
from app.routers.user_router import user_router
from app.routers.category_router import category_router
from app.routers.account_router import account_router
from app.routers.budget_router import budget_router
from app.routers.transaction_router import transaction_router
from app.routers.feedback_router import feedback_router
from app.routers.dashboard_router import dashboard_router
from app.routers.seed_router import seed_router
from app.routers.ai_router import ai_router
from app.jobs.ai_insight_job import refresh_daily_ai_insights_job
from apscheduler.schedulers.asyncio import AsyncIOScheduler

app = FastAPI()

# Add authentication middleware
# app.add_middleware(auth_middleware.AuthMiddleware)

# Add CORS middleware
add_cors_middleware(app)

# Include routers
app.include_router(ai_router, prefix="/api/ai", tags=["AI Assistant"])
app.include_router(dashboard_router, prefix="/api/dashboard", tags=["Dashboard"])
app.include_router(auth_router, prefix="/api/auth", tags=["Authentication"])
app.include_router(user_router, prefix="/api/users", tags=["User"])
app.include_router(category_router, prefix="/api/categories", tags=["Category"])
app.include_router(account_router, prefix="/api/accounts", tags=["Account"])
app.include_router(budget_router, prefix="/api/budgets", tags=["Budget"])
app.include_router(transaction_router, prefix="/api/transactions", tags=["Transaction"])
app.include_router(feedback_router, prefix="/api/feedbacks", tags=["Feedback"])
app.include_router(seed_router, prefix="/api/seed", tags=["Seed"])

scheduler = AsyncIOScheduler()
scheduler.add_job(
    refresh_daily_ai_insights_job,
    trigger="cron",
    hour=2,
    minute=0,
)