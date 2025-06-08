FROM python:3.10-slim

WORKDIR /app
COPY . .

RUN apt-get update && apt-get install -y supervisor && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8000

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
