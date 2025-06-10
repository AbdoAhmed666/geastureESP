from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware
import json
import os

app = FastAPI()

@app.get("/")
def root():
    return {"message": "GR-SYSTEM backend is up and running!"}

# CORS for frontend or Streamlit
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["GET"],
    allow_headers=["*"],
)

PREDICTION_FILE = os.path.join(os.path.dirname(__file__), "latest_prediction.json")

@app.get("/api/latest", response_class=Response, media_type="application/json")
async def get_latest_prediction():
    if not os.path.exists(PREDICTION_FILE):
        return json.dumps({"result": "No prediction yet", "confidence": 0.0})

    try:
        with open(PREDICTION_FILE, "r") as f:
            data = json.load(f)
        return json.dumps(data)
    except Exception as e:
        return Response(
            content=json.dumps({"error": str(e)}),
            status_code=500,
            media_type="application/json"
        )
