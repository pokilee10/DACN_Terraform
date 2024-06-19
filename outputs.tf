output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.my_cluster.name
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.my_security_group.id
}

output "ecs_service_1_name" {
  description = "Name of the ECS Service 1"
  value       = aws_ecs_service.service_1.name
}

output "ecs_service_2_name" {
  description = "Name of the ECS Service 2"
  value       = aws_ecs_service.service_2.name
}

output "ecs_service_3_name" {
  description = "Name of the ECS Service 3"
  value       = aws_ecs_service.service_3.name
}

output "DNS_fe" {
  description = "DNS of fe"
  value = aws_lb.service_1_nlb.dns_name
}

output "DNS_be" {
  description = "DNS of fe"
  value = aws_lb.service_2_nlb.dns_name
}

output "DNS_admin" {
  description = "DNS of fe"
  value = aws_lb.service_3_nlb.dns_name
}
    