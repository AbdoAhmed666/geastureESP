import threading
import uvicorn
import os

def run_fastapi():
    uvicorn.run("backend.fastapi_api:app", host="0.0.0.0", port=int(os.environ.get("PORT", 8000)))

def run_ws():
    import backend.ws_predictor
    import asyncio
    asyncio.run(backend.ws_predictor.main())

def run_ip_server():
    import backend.flask_ip_server
    backend.flask_ip_server.app.run(host="0.0.0.0", port=5000)

if __name__ == "__main__":
    threading.Thread(target=run_ip_server).start()
    threading.Thread(target=run_ws).start()
    run_fastapi()
