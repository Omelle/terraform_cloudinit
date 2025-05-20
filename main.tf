terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.39.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "proxmox" {
  endpoint = "https://192.168.33.128:8006/api2/json" # L'IP de ton hôte Proxmox et le port API par défaut
  username = var.pm_user
  password = var.pm_password
  insecure = true # Assurez-vous que vous êtes d'accord avec une connexion non sécurisée
}

locals {
  vm_names = ["grp1-devopsmaster", "grp1-cicdhub", "grp1-monitoring"]
  ip_addresses = {
    "grp1-devopsmaster" = "192.168.33.101/24" # Mettre à jour les adresses IP pour correspondre à ton réseau local
    "grp1-cicdhub"      = "192.168.33.102/24"
    "grp1-monitoring"   = "192.168.33.103/24"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = toset(local.vm_names)

  name      = each.key
  node_name = "pve" # Remplacer par le nom de ton noeud Proxmox si nécessaire

  clone {
    vm_id        = 9000 # ID du template Cloud-Init
    full         = true
    datastore_id = "local-lvm"
  }

  memory {
    dedicated = var.vm_memory
  }

  cpu {
    cores   = 2 # Limite le nombre de cores à 2
    sockets = 1 # 1 socket avec 2 cores
    type    = "kvm64"
  }


  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    size         = 60
    file_format  = "raw"
  }

  network_device {
    model  = "virtio"
    bridge = "vmbr0" # Assure-toi que cette interface existe sur ton hôte Proxmox
  }

  agent {
    enabled = true
  }

  initialization {
    datastore_id = "local-lvm"

    user_account {
      username = "root"
      password = "rootroot"
    }

    ip_config {
      ipv4 {
        address = lookup(local.ip_addresses, each.key)
        gateway = "192.168.33.254"
      }
    }
  }

}