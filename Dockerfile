FROM python:3.10-slim

WORKDIR /app

# انسخ فقط requirements الأول لتقليل إعادة بناء الـ cache
COPY requirements.txt ./

RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir uvicorn

COPY . .

# Debug statement عشان تتأكد إن uvicorn اتحمّل فعليًا
RUN echo "trigger rebuild $(date)" && \
    pip list && python3 -c "import uvicorn; print('✅ uvicorn موجود')"

EXPOSE 8000

CMD ["python3", "backend/combined_runner.py"]
