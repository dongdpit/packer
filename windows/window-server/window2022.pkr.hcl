###https://developer.hashicorp.com/packer/integrations/hashicorp/vsphere/latest/components/builder/vsphere-iso

packer {
#  required_version = ">=1.7.5"
  required_plugins {
    vsphere = {
      version = ">= 2.0.0"
      source  = "github.com/hashicorp/vsphere"
    }
    # if you would like to automatically install window updates, then uncomment
    # the following section. Please also uncomment Line 97-104

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
  vm_name       = "Win2022_Temp06102025"
#  folder        =
  cluster       = var.cluster
#  host          =
#  resource_pool =
  datastore     = var.datastore
#  convert_to_template = "true"

### Hardware Configuration
  CPUs                  = 4
#  cpu_cores             = 2
#  CPU_limit             = "10000"
  RAM                   = 4096
  RAM_reserve_all       = true
#  firmware              = "efi-secure", "efi", "bios"

### Create Configuration
#https://knowledge.broadcom.com/external/article?articleNumber=315655
#  vm_version    =
#https://knowledge.broadcom.com/external/article/321876/determine-the-guest-os-from-a-vm-configu.html
  guest_os_type = "windows2019srvNext_64Guest"

### ISO Configuration
  iso_checksum          = "4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852"
  iso_url               = "https://software-download.microsoft.com/download/sg/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
  iso_paths             = ["[vCenterHA-dbs] vmtools/windows.iso"]

### Floppy Configuration
  floppy_img_path       = "[vCenterHA-dbs] floppies/pvscsi-Windows8.flp"
  floppy_files          = ["./data/autounattend.xml", "../scripts/windows-init.ps1", "../scripts/vmtools.cmd", "../scripts/appx.ps1"]



### Network Adapter Configuration
  network_adapters {
    network      = var.network_name
    network_card = "vmxnet3"
  }

### Storage Configuration
#lsilogic-sas, pvscsi, nvme, scsi, sata
  disk_controller_type  = ["pvscsi"]
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }

### Wait Configuration
  ip_wait_timeout       = "3h"
  ip_settle_timeout     = "2m"

### Communicator Configuration
  communicator   = "winrm"
  winrm_username = var.winrm_username
  winrm_password = var.winrm_password
  winrm_timeout  = "3h"

### Shutdown Configuration
  shutdown_timeout      = "60m"

}

build {
  sources = [
    "source.vsphere-iso.this"
  ]

  # if you would like to automatically install window updates, then uncomment
  # the following section. Please also uncomment Line 13-16

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
