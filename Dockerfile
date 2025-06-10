FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
# final update without combined_runner
EXPOSE 8000
CMD ["uvicorn", "backend.fastapi_api:app", "--host", "0.0.0.0", "--port", "8000"]
