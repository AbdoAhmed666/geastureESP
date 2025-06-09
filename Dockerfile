FROM python:3.10-slim

WORKDIR /app

# بيئة لتحديد بورت WebSocket
ENV WS_PORT=8765

# تثبيت المتطلبات أولاً لتسريع الـ build
COPY requirements.txt ./
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir uvicorn

# نسخ باقي المشروع
COPY . .

# Debug statement
RUN echo "trigger rebuild $(date)" && \
    pip list && python3 -c "import uvicorn; print('✅ uvicorn موجود')"

# عرض البورتات المفتوحة (FastAPI + WebSocket)
EXPOSE 8000
EXPOSE 8765
EXPOSE 5000  # Flask IP server

# نقطة التشغيل
CMD ["python3", "-m", "backend.combined_runner"]
