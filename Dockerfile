FROM python:3.10-slim
WORKDIR /app
COPY . .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    apt-get update && apt-get install -y supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
