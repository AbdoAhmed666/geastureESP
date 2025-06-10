from fastapi import FastAPI, Response, Request
from fastapi.middleware.cors import CORSMiddleware
import json
import os

app = FastAPI()

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
def root():
    return {"message": "GR-SYSTEM backend is up and running!"}

# Path to prediction JSON file
PREDICTION_FILE = os.path.join(os.path.dirname(__file__), "latest_prediction.json")

@app.get("/api/latest", response_class=Response)
async def get_latest_prediction():
    if not os.path.exists(PREDICTION_FILE):
        return Response(content=json.dumps({"result": "No prediction yet", "confidence": 0.0}), media_type="application/json")

    try:
        with open(PREDICTION_FILE, "r") as f:
            data = json.load(f)
        return Response(content=json.dumps(data), media_type="application/json")
    except Exception as e:
        return Response(content=json.dumps({"error": str(e)}), status_code=500, media_type="application/json")

@app.post("/api/update")
async def update_prediction(request: Request):
    try:
        data = await request.json()
        with open(PREDICTION_FILE, "w") as f:
            json.dump(data, f)
        return {"status": "updated", "data": data}
    except Exception as e:
        return {"error": str(e)}
