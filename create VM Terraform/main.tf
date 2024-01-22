terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.87.0"
    }
  }
  required_version = ">= 0.14.9"
}


provider "azurerm" {
  features {}
}

#Creates a virtual network
resource "azurerm_virtual_network" "bryanesp" {
  name = "learn-tf-vnet-eastus"
  location = "eastus"
  resource_group_name = "bryan.espinosa"
  address_space = ["10.0.0.0/16"]
}

 #Create subnet
resource "azure_subnet" "bryanesp" {
  name = "learn-tf-subnet-eastus"
  virtual_network_name = azurerm_virtual_network.bryanesp.name
  resource_group_name = azurerm_resource_group.bryanesp.name
  address_prefixes = ["10.0.0.0/24"]
}
#Creates network interface card (NIC)
resource "azurerm_network_interface" "internal" {
  name                = "learn-tf-nic-eastus"
  location            = azurerm_resource_group.bryanesp.location
  resource_group_name = azurerm_resource_group.bryanesp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = "Dynamic"
  }
}
#Creates Virtual Machine 
resource "azurerm_windows_virtual_machine" "bryanesp" {
  name = "learn-tf-vm-eu" 
  resource_group_name = azurerm_resource_group.bryanesp.name
  location = azurerm_resource_group.bryanesp.location 
  size = "Standard_B1s"
  admin_username = "user.admin" 
    admin_password = "ED1rf0rnt$$$111"

    network_interface_ids = [
      azurerm_network_interface.internal.id
    ]

    os_disk {
      caching = "ReadWrite"
      storage_account_type = "standard_LRS"
    }

    source_image_reference {
      publisher = "MicrosoftwindowsServer"
      offer = "WindowsServer"
      sku = "2016-Datacenter"
      version = "latest"
    }  
  }