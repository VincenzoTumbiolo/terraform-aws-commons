# Output of module

output "vpc_id" {
  description = "vpc id"
  value       = aws_vpc.this
}
output "public_subnet1" {
  description = "first public subnet"
  value       = aws_subnet.public_subnet1
}
output "public_subnet2" {
  description = "second public subnet"
  value       = aws_subnet.public_subnet2
}
output "private_subnet1" {
  description = "first private subnet"
  value       = aws_subnet.private_subnet1
}
output "private_subnet2" {
  description = "second private subnet"
  value       = aws_subnet.private_subnet2
}
output "isolated_subnet1" {
  description = "first isolated subnet"
  value       = aws_subnet.isolated_subnet1
}
output "isolated_subnet2" {
  description = "second isolated subnet"
  value       = aws_subnet.isolated_subnet2
}