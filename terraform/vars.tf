variable "location" {
	type = string
	description = "Region de azure infraestructura"
	default = "West Europe"
}

variable "vm_size" {
	type = string
	description = "Tamaño de la maquina"
	default = "Standard_D1_v2" # 3.5 GB, 1 CPU
}
variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID for the Service Principal"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret for the Service Principal"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
