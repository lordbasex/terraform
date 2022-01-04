output "cluster_id" {
  description = "The ID of the CLUSTER"
  value       = aws_ecs_cluster.cluster.id
}

output "cluster_arn" {
  description = "The ARN of the CLUSTER"
  value       = aws_ecs_cluster.cluster.arn
}

output "cluster_name" {
  description = "The NAME of the CLUSTER"
  value       = aws_ecs_cluster.cluster.name
}


