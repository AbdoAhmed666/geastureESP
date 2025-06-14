# FROM python:3.10-slim

# WORKDIR /app

# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# COPY . .

# CMD ["uvicorn", "backend.fastapi_api:app", "--host", "0.0.0.0", "--port", "8000"]
# ---------- Base image for backend ----------
FROM python:3.10-slim AS backend

# Set workdir
WORKDIR /app

# Install system packages
RUN apt-get update && apt-get install -y build-essential curl

# Copy backend requirements
COPY backend/requirements.txt ./backend/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r backend/requirements.txt

# Copy backend source code
COPY backend ./backend


# ---------- Base image for frontend (React) ----------
FROM node:18 AS frontend

# Set workdir
WORKDIR /frontend

# Copy React app source
COPY frontend/package*.json ./
RUN npm install
COPY frontend ./frontend

# Build React static files
RUN npm run build


# ---------- Final production image ----------
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy backend from build stage
COPY --from=backend /app/backend ./backend

# Copy React build from frontend stage into backend folder
COPY --from=frontend /frontend/frontend/build ./frontend/build

# Reinstall any Python deps just in case (optional)
COPY backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port
ENV PORT=8000
EXPOSE 8000

# Start FastAPI app with Uvicorn
CMD ["uvicorn", "backend.fastapi_api:app", "--host", "0.0.0.0", "--port", "8000"]
