resource "aws_vpc" "this" {
  cidr_block           = "${var.vpc_ip}/${var.vpc_sub_mask_dimension}"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/vpc" })
}
