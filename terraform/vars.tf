variable "location" {
	type = string
	description = "Region de azure infraestructura"
	default = "West Europe"
}

variable "vm_size" {
	type = string
	description = "Tamaño de la maquina"
	default = "Standard_B1s" # 1 GB, 1 CPU
}
