import os
import threading
import uvicorn
import time
from backend.flask_ip_server import app as flask_app
from backend.fastapi_api import app as fastapi_app
from backend.ws_predictor import start_ws_server

def run_flask():
    flask_app.run(host="0.0.0.0", port=5000)

def run_fastapi():
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run(fastapi_app, host="0.0.0.0", port=port)

def run_ws():
    start_ws_server()

if __name__ == "__main__":
    threading.Thread(target=run_flask, daemon=True).start()
    threading.Thread(target=run_fastapi, daemon=True).start()
    threading.Thread(target=run_ws, daemon=True).start()

    # Prevent exit (Azure requires foreground process)
    while True:
        time.sleep(1)
