output "private_subnet_1a" {
  value = aws_subnet.private-us-east-1a.id
}
output "private_subnet_1b" {
  value = aws_subnet.private-us-east-1b.id
}
output "public_subnet_1a" {
  value = aws_subnet.public-us-east-1a.id
}
output "public_subnet_1b" {
  value = aws_subnet.public-us-east-1b.id
}
