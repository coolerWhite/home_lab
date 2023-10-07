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
#   pm_user = "root@pam"
  # pm_api_token_id = "root@pam"
  # pm_api_token_secret = "38b30aa4-9b7c-47ae-b0bc-f82ad542bb27"
  pm_tls_insecure = true
#   pm_otp = ""
  pm_user = "root@pam"
  pm_password = "123qweASD"
}

resource "proxmox_lxc" "ubuntu" {
  target_node = "pve"
  hostname = "lvc-ubuntu"
  ostemplate = "Storage:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  password = "gfhjkm"
  unprivileged = true

  rootfs {
    storage = "DATA-HDD"
    size = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}

# resource "proxmox_vm_qemu" "test" {
#   count = 1
#   name = "test-${count.index + 1}"

#   target_node = "pve"

    # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
  # another variable with contents "ubuntu-2004-cloudinit-template"
  # clone = var.template_name
  # # basic VM settings here. agent refers to guest agent
  # agent = 1
  # os_type = "cloud-init"
  # cores = 2
  # sockets = 1
  # cpu = "host"
  # memory = 2048
  # scsihw = "virtio-scsi-pci"
  # bootdisk = "scsi0"
  # disk {
  #   slot = 0
  #   # set disk size here. leave it small for testing because expanding the disk takes time.
  #   size = "10G"
  #   type = "scsi"
  #   storage = "local-zfs"
  #   iothread = 1
  # }
  
  # # if you want two NICs, just copy this whole network section and duplicate it
  # network {
  #   model = "virtio"
  #   bridge = "vmbr0"
  # }
  # # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  # lifecycle {
  #   ignore_changes = [
  #     network,
  #   ]
  # }
  
  # # the ${count.index + 1} thing appends text to the end of the ip address
  # # in this case, since we are only adding a single VM, the IP will
  # # be 10.98.1.91 since count.index starts at 0. this is how you can create
  # # multiple VMs and have an IP assigned to each (.91, .92, .93, etc.)
  # ipconfig0 = "ip=10.98.1.9${count.index + 1}/24,gw=10.98.1.1"
  
  # # sshkeys set using variables. the variable contains the text of the key.
  # sshkeys = <<EOF
  # ${var.ssh_key}
  # EOF

# }

