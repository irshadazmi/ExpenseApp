import os
from openai import AsyncOpenAI
from app.core.config import settings

client = AsyncOpenAI(api_key=settings.OPENAI_API_KEY)

async def ask_llm(prompt: str) -> str:

    resp = await client.chat.completions.create(
        model="gpt-4o-mini",
        messages=[
            {"role": "system", "content": "You translate user questions into safe SQL queries over PostgreSQL"},
            {"role": "user", "content": prompt}
        ],
        temperature=0
    )

    return resp.choices[0].message.content.strip()
