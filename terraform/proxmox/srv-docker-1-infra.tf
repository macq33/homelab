resource "proxmox_vm_qemu" "srv-docker-1-infra" {
  name = "srv-docker-1-infra"
  desc = "docker host for infrastructure"
  vmid = "100"
  clone = "debian12-cloudinit"

  memory = 4096
  cores = 2
  sockets = 1

  #ipconfig0 = "ip=192.168.0.50/24,gw=192.168.0.1"
  #nameserver = "8.8.8.8"
  
  target_node = "pve"
  agent = 1
  cpu = "host"
  os_type = "cloud_init"
  scsihw = "virtio-scsi-single"
  bootdisk = "scsi0"

  onboot = "true"

  disks {
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size = 30
          storage = "local-lvm"
        }
      }
    }
  }

  network {
      bridge = "vmbr0"
      model = "virtio"
  }

  # sshkeys = <<EOF
  # PLACE KEY HERE!
  # EOF
}