# C++ TCP Server on Kubernetes

High-performance TCP microservice in C++ with automated deployment via ArgoCD on local Kubernetes.

## Stack

- **Language**: C++17
- **Container**: Docker (multi-stage build with GCC)
- **Orchestration**: Kubernetes (Kind)
- **GitOps**: ArgoCD
- **Healthcheck**: TCP Socket Probe

## Structure

```
├── app/
│   ├── main.cpp              # TCP Server
│   ├── Dockerfile            # Multi-stage build
│   └── .dockerignore
├── k8s-manifests/
│   ├── deployment.yaml       # Deployment (2 replicas)
│   ├── service.yaml          # NodePort Service
│   └── kustomization.yaml
├── scripts/
│   └── connect.ps1           # TCP connection script
├── kind-config.yaml          # Cluster config
└── argocd-app.yaml           # GitOps Application
```

## Endpoints

| Port  | Protocol | Description |
|-------|----------|-------------|
| 30080 | TCP | Exposed service |
| 8000  | TCP | Container port / Healthcheck |

**Response**: `{"status":"ok","service":"cpp-server"}`

## Quick Start

### Connect to the server

```powershell
# Using the provided script
.\scripts\connect.ps1

# With custom parameters
.\scripts\connect.ps1 -Server localhost -Port 30080
```

## ArgoCD

- **URL**: https://localhost
- **User**: `admin`
- **Password**: `admin`

> Exposed via ingress-nginx with SSL passthrough — no port-forward needed.

## Commands

```powershell
# Pod status
kubectl get pods -l app=cpp-server

# Logs
kubectl logs -l app=cpp-server -f

# Restart
kubectl rollout restart deployment/cpp-server

# Build and deploy
docker build -t cpp-server:v1 ./app
kind load docker-image cpp-server:v1 --name cpp-cluster
kubectl rollout restart deployment/cpp-server

# ArgoCD UI (directly accessible at https://localhost)

# Delete cluster
kind delete cluster --name cpp-cluster
```

## License

MIT
