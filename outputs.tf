output "grafana_dashboard" {
  value = "https://${aws_route53_record.grafana.fqdn}"
}