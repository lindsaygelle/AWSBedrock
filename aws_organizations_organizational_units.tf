data "aws_organizations_organizational_units" "main" {
  parent_id = data.aws_organizations_organization.main.roots[0].id
}
