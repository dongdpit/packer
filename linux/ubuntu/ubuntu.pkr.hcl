packer {
  required_plugins {
    vsphere = {
      version = ">= 1.2.3"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

source "vsphere-iso" "this" {
### Connection Configuration
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_user
  password            = var.vsphere_password
  insecure_connection = true
  datacenter          = var.datacenter

### Location Configuration
  vm_name       = "Ubuntu22_Temp20082024"
#  folder        = ""
  cluster       = var.cluster
#  host          = var.host
#  resource_pool = var.resource_pool
  datastore     = var.datastore

### Hardware Configuration
  CPUs            = 4
#  cpu_cores       = 2
  RAM             = 4096
  RAM_reserve_all = true
#  firmware        = "bios", "efi", "efi-secure"

### Create Configuration
  guest_os_type = "ubuntu64Guest"
  network_adapters {
    network = var.network_name
  }

### CD-ROM Configuration
  iso_paths = ["[ESXiTest131_dbs] ubuntu-22.04.2-live-server-amd64.iso"]
  cd_files = ["./meta-data", "./user-data"]
  cd_label = "cidata"

### Storage Configuration
  storage {
    disk_size             = 32768
  }

### Boot Configuration
  boot_command = ["<wait>e<down><down><down><end> autoinstall ds=nocloud;<F10>"]

### SSH
  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  ssh_timeout  = "1h"

  /* Uncomment when running on vcsim
  ssh_host     = "127.0.0.1"
  ssh_port     = 2222

  configuration_parameters = {
    "RUN.container" : "lscr.io/linuxserver/openssh-server:latest"
    "RUN.mountdmi" : "false"
    "RUN.port.2222" : "2222"
    "RUN.env.USER_NAME" : "ubuntu"
    "RUN.env.USER_PASSWORD" : "ubuntu"
    "RUN.env.PASSWORD_ACCESS" : "true"
  }
  */

}

build {
  sources = [
    "source.vsphere-iso.this"
  ]

  provisioner "shell-local" {
    inline = ["echo the address is: $PACKER_HTTP_ADDR and build name is: $PACKER_BUILD_NAME"]
  }
}
