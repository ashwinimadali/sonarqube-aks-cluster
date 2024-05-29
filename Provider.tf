terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.104.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.7.0"
    }
    
  }
}

provider "azurerm" {
  features {
    
  }

  client_id       = "2fcdaf4b-608b-4d57-ba59-e608f2e82b7f"
  subscription_id = "688bbb24-df9e-4ca0-8c1d-ebe968c3671d"
  tenant_id       = "b0a69871-4f2a-4ff6-a556-4cc8d78aad82"
  client_secret   = "XSj8Q~x3-mX2b9KPXmIp7S5cHKS~CCo4yF3mzcr2"
}


