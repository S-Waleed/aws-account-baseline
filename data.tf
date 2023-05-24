data "aws_organizations_organization" "this" {}

# data "aws_organizations_organizational_units" "workload" {
#   parent_id = data.aws_organizations_organization.this.roots[0].id
# }
