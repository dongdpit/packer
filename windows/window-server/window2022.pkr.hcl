packer {
#  required_version = ">=1.7.5"
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
  vm_name       = "Win2022_Temp21082024"
#  folder        = ""
  cluster       = var.cluster
#  host          = var.host
#  resource_pool = var.resource_pool
  datastore     = var.datastore

### Hardware Configuration
  CPUs            = 4
  RAM             = 4096
  RAM_reserve_all = true
  firmware        = "efi-secure"

### Create Configuration
#  guest_os_type = "ubuntu64Guest"
  network_adapters {
    network = var.network_name
  }

### CD-ROM Configuration
  iso_paths  = ["[ESXiTest131_dbs] Win Server 2022.iso"]
  cd_files   = ["../scripts"]
  cd_content = {
    "autounattend.xml" = templatefile("./data/autounattend.pkrtpl.hcl", {
      build_username       = var.build_username
      build_password       = var.build_password
      vm_inst_os_eval      = var.vm_inst_os_eval
      vm_inst_os_language  = var.vm_inst_os_language
      vm_inst_os_keyboard  = var.vm_inst_os_keyboard
      vm_inst_os_image     = var.vm_inst_os_image_standard_desktop
      vm_inst_os_key       = var.vm_inst_os_key_standard
      vm_guest_os_language = var.vm_guest_os_language
      vm_guest_os_keyboard = var.vm_guest_os_keyboard
      vm_guest_os_timezone = var.vm_guest_os_timezone
    })
  }

### Storage Configuration
  storage {
    disk_size             = 40960
  }

### Boot Configuration
  boot_command = ["<spacebar>"]

### WinRM
  communicator   = "winrm"
  winrm_username = var.build_username
  winrm_password = var.build_password
  winrm_timeout  = "1h"

}

build {
  sources = [
    "source.vsphere-iso.this"
  ]

  provisioner "shell-local" {
    inline = ["echo the address is: $PACKER_HTTP_ADDR and build name is: $PACKER_BUILD_NAME"]
  }
}

