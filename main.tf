provider "aws" {
  region = "us-east-2"
}

resource "aws_eks_cluster" "example" {
  name     = "my-eks-cluster"
  role_arn = "arn:aws:iam::123456789012:role/eks-cluster-role"

  vpc_config {
    subnet_ids = ["subnet-12345678", "subnet-23456789"]
  }
}

resource "kubernetes_deployment" "nodejs-app" {
  metadata {
    name      = "nodejs-app"
    namespace = "default"
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "nodejs-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "nodejs-app"
        }
      }

      spec {
        container {
          image = "223438050602.dkr.ecr..${AWS_REGION}.amazonaws.com/tetris_images:latest"
          name  = "nodejs-app"
        }
      }
    }
  }
}
