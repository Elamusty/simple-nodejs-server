output "cluster_id" {
    value = module.eks.cluster_id
}
output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}

output "load_balancer_name" {
  value = local.lb_name
}

output "load_balancer_hostname" {
  value = kubernetes_service.nodeserver.status.0.load_balancer.0.ingress.0.hostname
}

output "load_balancer_info" {
  value = data.aws_elb.nodeserver_loadbalancer
}