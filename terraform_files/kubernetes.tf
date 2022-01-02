provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}


resource "kubernetes_deployment" "nodeserver" {
  metadata {
    name = "nodeserver-deployment"
    labels = {
      App = "nodeserver"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "nodeserver"
      }
    }
    template {
      metadata {
        labels = {
          App = "nodeserver"
        }
      }
      spec {
        container {
          image = "chinedave/paragon-node-server"
          name  = "paragon-node-server"

          port {
            container_port = 3000
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nodeserver" {
  metadata {
    name = "nodeserver-svc"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nodeserver.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}

# Create a local variable for the load balancer name.
locals {
  lb_name = split("-", split(".", kubernetes_service.nodeserver.status.0.load_balancer.0.ingress.0.hostname).0).0
}

# Read information about the load balancer using the AWS provider.
data "aws_elb" "nodeserver_loadbalancer" {
  name = local.lb_name
}

