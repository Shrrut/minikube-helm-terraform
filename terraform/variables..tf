variable "kubeconfig_path" {
  description = "Path to the kubeconfig file Minikube writes to"
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "kubectl context to use (Minikube's context is usually just 'minikube')"
  type        = string
  default     = "minikube"
}

variable "namespace" {
  description = "Kubernetes namespace the app is deployed into"
  type        = string
  default     = "myapp"
}

variable "backend_image_tag" {
  type    = string
  default = "v1"
}

variable "frontend_image_tag" {
  type    = string
  default = "v1"
}

variable "backend_replica_count" {
  type    = number
  default = 1
}

variable "frontend_replica_count" {
  type    = number
  default = 1
}

variable "db_username" {
  type    = string
  default = "appuser"
}

variable "db_password" {
  description = "Postgres password — pass via -var, never commit"
  type        = string
  sensitive   = true
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "ingress_host" {
  type    = string
  default = "myapp.local"
}