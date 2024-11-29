
# Variables (can also be placed in a separate variables.tf file)
variable "location" {
  description = "Azure region to deploy resources."
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group."
  default     = "rg-appgw-container-apps"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network."
  default     = ["10.0.0.0/16"]
}

variable "appgw_subnet_prefix" {
  description = "Subnet prefix for Application Gateway."
  default     = "10.0.1.0/24"
}

variable "containerapps_subnet_prefix" {
  description = "Subnet prefix for Container Apps."
  default     = "10.0.2.0/24"
}

variable "containerapps_environment_name" {
  description = "Name of the Azure Container Apps environment."
  default     = "containerapps-env"
}

variable "containerapp_names" {
  description = "List of Azure Container App names."
  type        = list(string)
  default     = ["containerapp1", "containerapp2"]
}

variable "containerapp1" {
  description = "Name of the Container App1."
  default     = "containerapp1"
}


variable "containerapp2" {
  description = "Name of the Container App2."
  default     = "containerapp2"
}

variable "public_ip_name" {
  description = "Name of the Public IP for Application Gateway."
  default     = "appgw-public-ip"
}

variable "container_app_1_image" {
  description = "Container image to deploy."
  default     = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
}

variable "container_app_2_image" {
  description = "Container image to deploy."
  default     = "stefanwalther/docker-test:latest"
}


variable "container_port" {
  description = "Port on which the container listens."
  default     = 80
}

variable "appgw_sku" {
  description = "SKU for Application Gateway."
  default     = "Standard_v2"
}