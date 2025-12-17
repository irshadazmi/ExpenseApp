# backend-api/app/jobs/ai_insight_job.py

from app.core.database import async_session
from app.repositories.user_repository import UserRepository
from app.repositories.ai_repository import AIRepository
from app.services.ai_service import AIService


async def refresh_daily_ai_insights_job():
    """
    APScheduler entrypoint.
    Creates DB session manually.
    """
    async with async_session() as db:
        user_repo = UserRepository(db)
        ai_repo = AIRepository(db)
        service = AIService(ai_repo)

        users = await user_repo.get_all_active_users()

        for user in users:
            try:
                await service.generate_insights(user.id)
            except Exception as e:
                # isolate failure per user
                print(
                    f"[AI INSIGHTS JOB] Failed for user {user.id}: {e}"
                )
