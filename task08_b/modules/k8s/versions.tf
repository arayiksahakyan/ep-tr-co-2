terraform {
  required_providers {
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.4.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30.0"
    }
  }
}
