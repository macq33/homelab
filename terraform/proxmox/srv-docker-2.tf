resource "proxmox_vm_qemu" "srv-docker-2" {
  name  = "srv-docker-2"
  desc  = "docker host for infrastructure"
  vmid  = "101"
  clone = "debian12-cloudinit"

  memory  = 4096
  cores   = 2
  sockets = 1

  ipconfig0 = "ip=192.168.0.101/24,gw=192.168.0.1"
  #nameserver = "8.8.8.8"

  target_node = "pve"
  agent       = 1
  cpu         = "host"
  os_type     = "cloud_init"
  scsihw      = "virtio-scsi-single"
  bootdisk    = "scsi0"

  onboot = "true"

  ciuser = "sensei"

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
          size    = 30
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  sshkeys = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDThHn82mWheEtbPQNa1xgOMmNnaODPG2JioWsw9R0qVa/wcKIHtD+kCSHXiKJRvy1cvypa67OZsp58rDASXOClpYzDnD/s0N8bk4lB1MDrmjaS+dUJToyJckgiNPnmg4QgQ3W7/CfpZll8wSjmnXhESH5+hRLeGVNeXYBsWVYjL023NlBZdVvgXALeAc5jKIUd+eJt2g6sjp1qnXAUotLFnax4axTioIC8333fSBTcGnMoq6K/GB3UQScA9SbpufhkK0EzcKcfVIyZu5fvXD6mfx5VJNaRFHy7CV4NZSV4IBE1OEi+dyyCNSVGDSJgMExPfZgXBXG8ErSkEDmnBFJ9 rsa-key-maciejkol
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCETUNSGrfFbFk+B3kq5kj6JiaqXFTleKtmM4whnpLNn5auCmobnrKINRRUfub5VlErlwnAC+wz2RRym6wHLmYNTWuthqMSXEZ0CSaqu72zMaf6epJ3o6enAo2aoOcJBEQLmm1rkEzCCVXB+JA944TvBNC9rerPOIpn8K+L5h+bH+iw2ZUCyx4EFIdQ/6APhvsg3PXuD/zPkpBj4co+ZBBGwMe4Rc/aNReDns6Lozg4O1VQdFat//HSHvu+pR1wKqSxO5Dc0REW3zzEAC59IUBcZy0JOsXDHhQyIoy9Xw0OLBBEvbFGf6aNnjXyjwGXisnRQAn1njwOAlprdEN2N2kwJ+fnyrQSrUo/5ROMvScuud9S2dz6K4X5Rc5MkF3ZkTT3ldyC9eR2L/z12gm7Tbc4JnC9TnyYEQAcxEAh5ZpVEcsQMAyBj+Y3H2UMmU2IRmQGCGhOBuHqCL+ldLXMXYR4SxZ65gTUb6Kkipar59OB36gksPCbLTkkqrXAZ/aXNMVF8YVRhTl7gUgBcauEKDTs5AOUWe+JlLzkd81UCA2hV0GGaZ4Y6dNLhTXsY1gTpSALwpj0RqapoZT1iYXE66na1UPQ/gjF1J+ksxEMgA6eSFeMs6Io/8bW6FDHJNsUlZ+cm7Hez4w6c2Tl7uhiwkJoK+js0yy8Ls3GuO63IG7FHQ== ansible-maciejkol
  EOF
}