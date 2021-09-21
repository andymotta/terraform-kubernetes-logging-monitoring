# For prom operator
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "prometheus-community"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  values = [
    templatefile("${path.module}/kube-prometheus-chart-values.yaml", {
      certificate_arn = var.certificate_arn
      domain_name = var.domain_name
    })
  ]
  depends_on = [kubernetes_namespace.monitoring]
}

data "kubernetes_ingress" "grafana" {
  metadata {
    name = "prometheus-grafana"
    namespace = "monitoring"
  }
  depends_on = [helm_release.prometheus]
}

resource "aws_route53_record" "grafana" {
  provider = aws.dns
  zone_id  = var.zone_id
  name     = "grafana.${var.domain_name}"
  type     = "CNAME"
  ttl      = "300"
  records = [data.kubernetes_ingress.grafana.status.0.load_balancer.0.ingress.0.hostname]
}