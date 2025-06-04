# استخدم Python 3.10 الرسمي
FROM python:3.10-slim

# إعداد مجلد العمل داخل الحاوية
WORKDIR /app

# نسخ ملفات المشروع
COPY . .

# تثبيت المتطلبات
RUN pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt

# تشغيل السيرفر
CMD ["python", "backend/ws_predictor.py"]
