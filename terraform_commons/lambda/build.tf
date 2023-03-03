#---------------------------------------------------------------------------------------------------
# Build and package the source archive.
#---------------------------------------------------------------------------------------------------

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_dir
  excludes    = var.exclude_files
  output_path = var.output_path
}
