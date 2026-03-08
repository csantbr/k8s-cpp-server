from fastapi import FastAPI

app = FastAPI(title="Hello World API", version="1.0.0")


@app.get("/")
async def hello_world():
    """Endpoint principal que retorna Hello World."""
    return {"message": "Hello World! v2 - Updated via ArgoCD"}


@app.get("/health")
async def healthcheck():
    """Endpoint de healthcheck para o Kubernetes."""
    return {"status": "healthy"}
