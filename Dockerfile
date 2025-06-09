FROM python:3.10-slim

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y gcc && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "backend.fastapi_api:app", "--host", "0.0.0.0", "--port", "8000"]
