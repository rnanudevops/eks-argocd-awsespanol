resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "5.34.3"

  create_namespace = true

  values = [
    <<-EOF
    server:
      service:
        type: LoadBalancer
    EOF
  ]
  depends_on = [ module.eks ]
}

resource "kubectl_manifest" "argocd_service" {
  yaml_body = <<-YAML
  apiVersion: v1
  kind: Service
  metadata:
    name: argocd-server
    namespace: argocd
YAML

depends_on = [helm_release.argocd, module.eks]
}