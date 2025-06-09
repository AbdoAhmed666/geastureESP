FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt ./
RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .
# Force rebuild: Trigger full Docker cache bust
RUN echo "trigger rebuild $(date)"
EXPOSE 8000

CMD ["python3.10", "backend/combined_runner.py"]
