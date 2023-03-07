output "atlasdb_security_group" {
  value = aws_security_group.atlasdb
}

output "atlasdb_uri" {
  value = "mongodb+srv://${var.dbUser}:${var.dbPassword}@${local.endpoint_db_uri}/${var.databaseName}?retryWrites=true&w=majority"
}
