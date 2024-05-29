# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "sonarqube-rg"
  location = "West US" # Change to your desired location
}

# Create AKS cluster

provider "kubernetes" {
  config_context_cluster = "sonarqube-aks-cluster"  # Update with your AKS cluster name
  config_path            = "C:\\Users\\AMADALI\\.kube\\config"  # Update with your kubeconfig file path
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "sonarqube-aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "sonarqube-aks-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }
 identity {
    type = "SystemAssigned"
  }
}

# Deploy SonarQube on AKS
resource "kubernetes_deployment" "sonarqube" {
  metadata {
    name = "sonarqube"
    labels = {
      app = "sonarqube"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "sonarqube"
      }
    }

    template {
      metadata {
        labels = {
          app = "sonarqube"
        }
      }

      spec {
        container {
          name  = "sonarqube"
          image = "sonarqube:latest"
          port {
            container_port = 9000
          }
        }
      }
    }
  }
}

# Expose SonarQube service
resource "kubernetes_service" "sonarqube" {
  metadata {
    name = "sonarqube"
  }

  spec {
    selector = {
      app = "sonarqube"
    }

    port {
      protocol    = "TCP"
      port        = 9000
      target_port = 9000
    }

    type = "LoadBalancer"
  }
}
