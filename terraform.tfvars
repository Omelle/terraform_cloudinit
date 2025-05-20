# terraform.tfvars

pm_user     = "root@pam"  # Exemple d'utilisateur Proxmox
pm_password = "xdczos99!" # Le mot de passe d'accès à l'API
vm_memory   = 4096        # Exemple, on attribue 4 Go de RAM aux VMs
vm_cores    = 4           # Exemple, 4 cœurs CPU

# Si tu veux aussi personnaliser les adresses IP ou d'autres variables :
ip_addresses = {
  "grp1-devopsmaster" = "192.168.33.101/24"
  "grp1-cicdhub"      = "192.168.33.102/24"
  "grp1-monitoring"   = "192.168.33.103/24"
}

gateway = "192.168.33.254" # Assurez-vous que la passerelle est correcte pour ton réseau
