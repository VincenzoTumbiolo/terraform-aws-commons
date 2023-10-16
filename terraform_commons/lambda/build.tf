#---------------------------------------------------------------------------------------------------
# Build and package the source archive.
#---------------------------------------------------------------------------------------------------
resource "null_resource" "build" {
  count = var.build_command != "" ? 1 : 0

  triggers = var.build_triggers

  provisioner "local-exec" {
    command     = var.build_command
    working_dir = var.working_dir
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_file = var.source_file != null ? var.source_file : null
  source_dir  = var.source_dir != null ? var.source_dir : null
  output_path = var.output_path

  depends_on = [null_resource.build]
}
