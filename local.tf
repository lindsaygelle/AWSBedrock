locals {
  organization = (var.organization != null ? var.organization : lower(random_pet.organization.id))
}

locals {
  tags = {
    caller_identity_account_arn = data.aws_caller_identity.main.arn
    caller_identity_account_id  = data.aws_caller_identity.main.account_id
    caller_identity_user_id     = data.aws_caller_identity.main.user_id
    canonical_user_id           = data.aws_canonical_user_id.main.id
    elb_arn                     = data.aws_elb_service_account.main.arn
    organization                = local.organization
    //organization_account_id                          = data.aws_organizations_organization.main.roots[0].account_id
    organization_arn = data.aws_organizations_organization.main.roots[0].arn
    //organization_master_account_master_account_arn   = data.aws_organizations_organization.main.roots[0].master_account_arn
    //organization_master_account_master_account_email = data.aws_organizations_organization.main.roots[0].master_account_email
    //organization_master_account_master_account_id    = data.aws_organizations_organization.main.roots[0].master_account_id
    //organization_master_account_master_account_name  = data.aws_organizations_organization.main.roots[0].master_account_name
    partition                    = data.aws_partition.main.partition
    partition_dns_suffix         = data.aws_partition.main.dns_suffix
    partition_id                 = data.aws_partition.main.id
    partition_reverse_dns_prefix = data.aws_partition.main.reverse_dns_prefix
    region                       = data.aws_region.main.name
    workspace                    = terraform.workspace
  }
}
