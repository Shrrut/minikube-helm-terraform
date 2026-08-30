resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "backend" {
  name      = "backend"
  namespace = kubernetes_namespace.app.metadata[0].name
  chart     = "${path.module}/../helm/backend-chart"

  set {
    name  = "replicaCount"
    value = var.backend_replica_count
  }

  set {
    name  = "image.tag"
    value = var.backend_image_tag
  }

  set {
    name  = "postgresql.auth.username"
    value = var.db_username
  }

  set {
    name  = "postgresql.auth.password"
    value = var.db_password
  }

  set {
    name  = "postgresql.auth.database"
    value = var.db_name
  }

  wait    = true
  timeout = 300
}

resource "helm_release" "frontend" {
  name      = "frontend"
  namespace = kubernetes_namespace.app.metadata[0].name
  chart     = "${path.module}/../helm/frontend-chart"

  set {
    name  = "replicaCount"
    value = var.frontend_replica_count
  }

  set {
    name  = "image.tag"
    value = var.frontend_image_tag
  }

  set {
    name  = "backend.host"
    value = "backend-svc"
  }

  set {
    name  = "backend.port"
    value = "5000"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress.host"
    value = var.ingress_host
  }

  wait    = true
  timeout = 180

  depends_on = [helm_release.backend]
}