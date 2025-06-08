FROM python:3.10-slim

WORKDIR /app

COPY . .

RUN pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt

CMD ["python", "backend/ws_predictor.py"]  # Default لو مش محدد command في docker-compose
