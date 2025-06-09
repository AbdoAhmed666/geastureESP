from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import json
import os

app = FastAPI()

# ✅ Root endpoint
@app.get("/")
def root():
    return {"message": "GR-SYSTEM backend is up and running!"}

# CORS for frontend polling
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET"],
    allow_headers=["*"],
)

PREDICTION_FILE = os.path.join(os.path.dirname(__file__), "latest_prediction.json")

@app.get("/api/latest")
async def get_latest_prediction():
    if not os.path.exists(PREDICTION_FILE):
        return {"result": "No prediction yet", "confidence": 0.0}

    try:
        with open(PREDICTION_FILE, "r") as f:
            data = json.load(f)
        return data
    except Exception as e:
        return {"error": str(e)}
