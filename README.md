# Full-Stack Microservices Platform on Kubernetes

A microservices architecture deployed to Kubernetes using Infrastructure as Code (IaC). It has a Node.js/Express backend connected to a PostgreSQL database, and a vanilla JavaScript frontend served by NGINX acting as a reverse proxy.

## Features
- **Infrastructure as Code:** Automated multi-service Kubernetes deployments using Terraform with the Kubernetes and Helm providers.
- **Modular Helm charts:** Custom charts using Go templating for per-environment parameterization, ConfigMap injection, and Kubernetes Secret management.
- **Database orchestration:** Bitnami PostgreSQL chart as a dependency, with automated schema initialization and retry logic in the backend.
- **Frontend reverse proxy:** NGINX serves static assets and routes `/api/` traffic to the backend service.
- **Cluster configuration:** CPU/memory limits, readiness/liveness probes, and ordered deployment dependencies (`depends_on`) for reliable rollouts.

## Technologies Used
- **Frontend:** HTML, CSS, vanilla JavaScript, NGINX
- **Backend:** Node.js, Express, PostgreSQL (`pg`)
- **DevOps/IaC:** Terraform, Kubernetes, Helm, Docker

## Getting Started

### Prerequisites
- Minikube (or another Kubernetes cluster) running locally
- Terraform `>= 1.5.0`
- Helm `~> 3.0`
- `kubectl` configured for your cluster

### Deployment
1. Start your local cluster:
```bash
   minikube start
```
2. Enable the NGINX Ingress controller:
```bash
   minikube addons enable ingress
```
3. Change to the Terraform directory.
4. Initialize Terraform:
```bash
   terraform init
```
5. Review the execution plan, replacing the placeholder with a secure password:
```bash
   terraform plan -var="db_password=YourSecurePassword"
```
6. Deploy the infrastructure (frontend, backend, and PostgreSQL):
```bash
   terraform apply -var="db_password=YourSecurePassword"
```
7. Map the Ingress host to your Minikube IP in `/etc/hosts`. Get the IP with `minikube ip`:
```text
   127.0.0.1 myapp.local
```
   Use `127.0.0.1` only if you're running `minikube tunnel` (typical with the Docker driver on macOS/Windows).
8. Open http://myapp.local in your browser.

### Teardown
To remove all deployed resources:
```bash
terraform destroy -var="db_password=YourSecurePassword"
```
