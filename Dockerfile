FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# ⛳️ CMD موجه للملف الموجود فعلاً داخل backend/
CMD ["uvicorn", "backend.fastapi_api:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

