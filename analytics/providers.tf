# ------------------------ PROVIDER ---------------------------
provider "aws" {
  region = var.region
}

provider "mongodbatlas" {}
