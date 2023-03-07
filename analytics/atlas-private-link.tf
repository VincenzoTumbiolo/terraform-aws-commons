resource "mongodbatlas_privatelink_endpoint" "atlaspl" {
  project_id    = var.atlasProjectId
  provider_name = "AWS"
  region        = var.region
}

resource "aws_vpc_endpoint" "ptfe_service" {
  vpc_id             = var.vpcId
  service_name       = mongodbatlas_privatelink_endpoint.atlaspl.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = local.isolatedSubnetIds
  security_group_ids = [aws_security_group.atlasdb.id]

  tags = local.tags
}

resource "mongodbatlas_privatelink_endpoint_service" "atlaseplink" {
  project_id          = mongodbatlas_privatelink_endpoint.atlaspl.project_id
  endpoint_service_id = aws_vpc_endpoint.ptfe_service.id
  private_link_id     = mongodbatlas_privatelink_endpoint.atlaspl.id
  provider_name       = "AWS"
}
