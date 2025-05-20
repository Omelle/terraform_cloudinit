# variables.tf

variable "pm_api_url" {
  description = "URL de l'API de l'hôte Proxmox"
  type        = string
  default     = "https://192.168.33.128:8006/api2/json" # Par défaut l'URL de ton hôte Proxmox
}

variable "pm_user" {
  description = "Nom d'utilisateur pour se connecter à l'API Proxmox"
  type        = string
}

variable "pm_password" {
  description = "Mot de passe pour se connecter à l'API Proxmox"
  type        = string
  sensitive   = true
}

variable "vm_memory" {
  description = "Mémoire allouée aux machines virtuelles (en Mo)"
  type        = number
  default     = 2048 # Par défaut, 2 Go de RAM
}

variable "vm_cores" {
  description = "Nombre de cœurs CPU alloués aux machines virtuelles"
  type        = number
  default     = 2 # Par défaut, 2 cœurs
}

variable "vm_names" {
  description = "Liste des noms de machines virtuelles"
  type        = list(string)
  default     = ["grp1-devopsmaster", "grp1-cicdhub", "grp1-monitoring"]
}

variable "ip_addresses" {
  description = "Adresses IP des machines virtuelles"
  type        = map(string)
  default = {
    "grp1-devopsmaster" = "192.168.33.101/24"
    "grp1-cicdhub"      = "192.168.33.102/24"
    "grp1-monitoring"   = "192.168.33.103/24"
  }
}

variable "gateway" {
  description = "Adresse IP de la passerelle"
  type        = string
  default     = "192.168.33.254" # Adresse de la passerelle du réseau local
}

variable "datastore_id" {
  description = "Identifiant du datastore Proxmox"
  type        = string
  default     = "local-lvm" # Par défaut, utilise 'local-lvm'
}
