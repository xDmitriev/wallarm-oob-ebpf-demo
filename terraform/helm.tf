resource "helm_release" "oob_ebpf" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "oob-ebpf-demo"
  repository = "https://charts.wallarm.com"
  chart      = "wallarm-oob"
  namespace  = "wallarm-oob"
  version    = "0.1.0"
  set {
    name  = "config.api.token"
    value = var.wallarm_api_token
  }
  set {
    name  = "config.api.host"
    value = var.wallarm_api_host
  }

  create_namespace = true
}

resource "helm_release" "ingress_nginx" {
  depends_on = [azurerm_kubernetes_cluster.aks]
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  version    = "4.4.0"
  values     = [file("../helm-values/ingress.yaml")]

  create_namespace = true
}