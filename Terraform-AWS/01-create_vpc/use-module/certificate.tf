module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = "weekly.tf"
  zone_id     = "b7d259641bf30b89887c943ffc9d2138"

  subject_alternative_names = [
    "*.weekly.tf",
  ]

  create_route53_records  = false
  validation_record_fqdns = [
    "_689571ee9a5f9ec307c512c5d851e25a.weekly.tf",
  ]

  tags = {
    Name = "weekly.tf"
  }
}