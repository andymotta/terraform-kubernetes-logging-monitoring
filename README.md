# Kubernetes Monitoring and Logging
Pluggable Terraform module to install basic monitoring and logging on Kubernetes clusters

## Usage
Passing a provider alias when DNS zone is in a different account
```hcl
module "monitoring" {
  providers = {
    aws.dns = aws.dns
  }
  source = "./modules/monitoring"
  certificate_arn = module.acm_domain_wildcard.certificate_arn
  zone_id = data.aws_route53_zone.externaldns_link.zone_id
  domain_name = var.domain_name
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of a domain that you own | `string` | `""` | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Public zone for domain that will hold the domain verification records | `string` | `""` | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | AWS ACM Certificate arn for exposed Grafana | `string` | `""` | yes |