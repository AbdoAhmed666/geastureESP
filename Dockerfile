FROM python:3.10-slim

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8000
EXPOSE 5000
EXPOSE 8765

CMD ["python", "backend/combined_runner.py"]
