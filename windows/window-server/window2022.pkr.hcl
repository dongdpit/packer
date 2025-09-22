packer {
#  required_version = ">=1.7.5"
  required_plugins {
    vsphere = {
      version = ">= 1.2.3"
      source  = "github.com/hashicorp/vsphere"
    }
    # if you would like to automatically install window updates, then uncomment
    # the following section. Please also uncomment Line 163-170

    # windows-update = {
    #   version = "0.14.0"
    #   source = "github.com/rgl/windows-update"
    # }
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
  CPUs                  = 4
  RAM                   = 4096
  RAM_reserve_all       = true
  firmware              = "efi-secure"
  disk_controller_type  = ["pvscsi"]

### Create Configuration
  guest_os_type = "windows2019srvNext_64Guest"
  network_adapters {
    network      = var.network_name
    network_card = "vmxnet3"
  }

  floppy_files          = ["${var.autounattend_file}", "setup/setup.ps1", "setup/vmtools.cmd", "setup/appx.ps1"]
  floppy_img_path       = "${var.floppy_pvscsi}"

### CD-ROM Configuration
  iso_checksum          = "${var.os_iso_checksum}"
  iso_url               = "${var.os_iso_url}"
  iso_paths             = ["${var.vmtools_iso_path}"]

### Storage Configuration
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }

### Boot Configuration
#  boot_command = ["<spacebar>"]

### WinRM
  communicator   = "winrm"
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout  = "3h"

  shutdown_timeout      = "60m"

  ip_wait_timeout       = "3h"
  ip_settle_timeout     = "2m"

}

build {
  sources = [
    "source.vsphere-iso.this"
  ]

  # if you would like to automatically install window updates, then uncomment
  # the following section. Please also uncomment Line 11-14

  # provisioner "windows-update" {
  #   search_criteria = "IsInstalled=0"
  #   filters = [
  #     "exclude:$_.Title -like '*Preview*'",
  #     "include:$true",
  #   ]
  #   update_limit = 25
  # }

  provisioner "windows-shell" {
    inline = ["dir c:\\"]
  }
}

