terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.4"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.100:8006/api2/json"
  pm_tls_insecure = true
  pm_user = "root@pam"
  pm_password = "123qweASD"
}



resource "proxmox_vm_qemu" "DNS-windows" {
  name = "DNS"
  target_node = "pve"
  iso = "ru-ru_windows_server_2022_updated_aug_2023_x64_dvd_78639bda.iso"

  os_type = "cloud-init"

  agent = 1
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  
  disk {
    slot = 0
    size = "30G"
    type = "scsi"
    storage = "DATA-HDD"
    iothread = 1
  }

}