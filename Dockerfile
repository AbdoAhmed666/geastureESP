FROM python:3.10-slim

WORKDIR /app

# بيئة لتحديد بورت WebSocket
ENV WS_PORT=8765

# تثبيت المتطلبات
COPY requirements.txt ./
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir uvicorn

# نسخ باقي ملفات المشروع
COPY . .

# Debug check
RUN echo "trigger rebuild $(date)" && \
    pip list && python -c "import uvicorn; print('✅ uvicorn موجود')"

# Expose ports
EXPOSE 8000
EXPOSE 8765
EXPOSE 5000

# Start
CMD ["python", "-m", "backend.combined_runner"]
