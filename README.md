# FastAPI Hello World no Kubernetes

Projeto de API Hello World em FastAPI rodando em Kubernetes local com ArgoCD.

## Estrutura

```
k8s/
├── app/                      # Código da aplicação
│   ├── main.py               # API FastAPI
│   ├── requirements.txt      # Dependências Python
│   ├── Dockerfile            # Imagem Docker
│   └── .dockerignore
├── k8s-manifests/            # Manifests Kubernetes
│   ├── deployment.yaml       # Deployment da aplicação
│   ├── service.yaml          # Service NodePort
│   └── kustomization.yaml    # Kustomize config
├── kind-config.yaml          # Configuração do cluster Kind
└── argocd-app.yaml           # Application ArgoCD (template)
```

## Acessos

### API FastAPI
- **URL**: http://localhost:30080
- **Endpoints**:
  - `GET /` - Hello World
  - `GET /health` - Healthcheck

### ArgoCD UI
- **URL**: https://localhost:8080
- **Usuário**: `admin`
- **Senha**: `0XajmEgsIo-dZZ3W`

## Comandos Úteis

### Verificar pods
```powershell
kubectl get pods
```

### Ver logs da aplicação
```powershell
kubectl logs -l app=fastapi-hello -f
```

### Reiniciar deployment
```powershell
kubectl rollout restart deployment/fastapi-hello
```

### Acessar ArgoCD (se o port-forward parou)
```powershell
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Rebuild da imagem
```powershell
cd app
docker build -t fastapi-hello:latest .
kind load docker-image fastapi-hello:latest --name fastapi-cluster
kubectl rollout restart deployment/fastapi-hello
```

### Deletar cluster
```powershell
kind delete cluster --name fastapi-cluster
```
