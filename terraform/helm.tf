resource "helm_release" "oob" {
  depends_on = [
    azurerm_kubernetes_cluster.aks,
    helm_release.cert-manager
  ]

  name       = "oob-ebpf"
  repository = "https://charts.wallarm.com"
  chart      = "wallarm-oob"
  namespace  = "oob-ebpf"

  set {
    name  = "config.api.host"
    value = var.wallarm_api_host
  }
  set_sensitive {
    name  = "config.api.token"
    value = var.wallarm_api_token
  }

  create_namespace = true
}

resource "helm_release" "ingress_nginx" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  values     = [file("../helm-values/nginx-ingress.yaml")]

  create_namespace = true
}

resource "helm_release" "cert-manager" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "cer-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"
  wait       = true

  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }
}
