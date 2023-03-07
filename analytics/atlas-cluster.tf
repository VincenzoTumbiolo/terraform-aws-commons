# info at https://github.com/mongodb/terraform-provider-mongodbatlas/tree/master/examples/aws-atlas-privatelink

resource "mongodbatlas_cluster" "cluster-atlas" {
  project_id                   = var.atlasProjectId
  name                         = "${var.env}-${local.tags.project-prefix}-cluster-atlas"
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = var.atlasdb_major_version
  cluster_type                 = var.atlasdb_cluster_type
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = upper(var.region)
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  # Provider settings
  provider_name               = "AWS"
  disk_size_gb                = var.atlasdb_disk_size_gb
  provider_instance_size_name = var.atlasdb_provider_instance_size_name
}

data "mongodbatlas_cluster" "cluster-atlas" {
  project_id = var.atlasProjectId
  name       = mongodbatlas_cluster.cluster-atlas.name
  depends_on = [mongodbatlas_privatelink_endpoint_service.atlaseplink]
}

# DATABASE USER
resource "mongodbatlas_database_user" "user1" {
  username           = var.dbUser
  password           = var.dbPassword
  project_id         = var.atlasProjectId
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.databaseName
  }
  labels {
    key   = "Name"
    value = "DB User1"
  }

  scopes {
    name = mongodbatlas_cluster.cluster-atlas.name
    type = "CLUSTER"
  }
}

locals {
  atlasclusterstring      = data.mongodbatlas_cluster.cluster-atlas.connection_strings
  endpoint_db_uri         = split("//", lookup(mongodbatlas_cluster.cluster-atlas.connection_strings[0].aws_private_link_srv, aws_vpc_endpoint.ptfe_service.id))[1]
  cluster_endpoint_db_uri = split("//", mongodbatlas_cluster.cluster-atlas.connection_strings[0].standard_srv)[1]
}
