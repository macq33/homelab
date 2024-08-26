resource "proxmox_vm_qemu" "k8s-talos-cp-2" {
  name        = "k8s-talos-cp-2"
  desc  = "talos os control plane"
  target_node = "pve"
  vmid  = "201"

  memory  = 2048
  cores   = 2
  sockets = 1

  agent = 1
  onboot = "true"
  scsihw      = "virtio-scsi-single"

  disks {
    ide {
      ide2 {
        cdrom {
          iso = "local-dir-1:iso/talos-v1.7.6-metal-amd64.iso"
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = 20
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
    macaddr = "0A:34:79:43:C4:01"
  }


  ### or for a Clone VM operation
  # clone = "template to clone"

  ### or for a PXE boot VM operation
  # pxe = true
  # boot = "scsi0;net0"
  # agent = 0
}