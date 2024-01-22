terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.87.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}

# Create static web app  https://www.pulumi.com/ai/answers/9B9tm9agatD3bhbz3CTEJf/azure-static-web-apps-deployment-with-terraform

variable "location" {
  description = "The Azure location where all resources in this example will be created"
  default     = "West Europe"
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = var.location
}

resource "azurerm_static_site" "example" {
  name                = "example-staticsite"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = "FREE"

  source {
    branch             = "main"
    repo_token         = "xxxxxxxxxx" # Your GitHub Repository Token
    repository_url     = "https://github.com/username/repository-name"
    output_location    = "/location-to-application-outputs"  
  }

  lifecycle {
    ignore_changes = [source[0].repo_token]
  }
}

output "static_web_app_id" {
  description = "The ID of the Static Web App."
  value       = azurerm_static_site.example.id
}

output "static_web_app_default_hostname" {
  description = "The default hostname associated with the Static Web App."
  value       = azurerm_static_site.example.default_hostname
}