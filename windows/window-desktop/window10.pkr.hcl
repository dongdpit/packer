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
  vm_name       = "Win10_Temp06102025"
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
  guest_os_type = "windows9_64Guest"

### ISO Configuration
#  iso_checksum          = "edc53c5c5fe6926dea23fc3e884fbcf78cc2b9e76364be968f806fc6d42b59d2"
#  iso_url               = "https://software.download.prss.microsoft.com/dbazure/Win10_22H2_EnglishInternational_x64v1.iso?t=e7dce0ae-6410-4c71-8b6f-744f5d37ba40&P1=1758708244&P2=601&P3=2&P4=mI5Rrm9hVAY6HrOcWw%2fOLu44WWbd4Ho7qsioKUp7NP938hN2a3j3E3nrQJ61U%2bL4y8c%2fPLcxLDpW3%2bzxd6SrjECpryvpOMivEBZP05mu5yoburW26m1XsSd8b2d%2fcpKgGVfLeBogngJuwZnrW1eL6ac9FoIz3wKwOHK9SN1I8Kltto4gq0yeayLv4nrd5lhqzWoMx9DtMQUvMpVrphllB9APN9q45gUr2tLTGTuUrufxclraKtnkg3479kzyaI5LFUm9jmCarWOAkiR40pjP8Mp%2fFwh5bpPNCE70AirsfW%2b1ynq86gYWzBMf76En15msvf%2bF1yXTYG3%2fzvFX3e0AcA%3d%3d"
  iso_paths             = ["[vCenterHA-dbs] vmtools/windows.iso"]

  iso_checksum          = "026607e7aa7ff80441045d8830556bf8899062ca9b3c543702f112dd6ffe6078"
  iso_url               = "https://software-download.microsoft.com/download/sg/19043.928.210409-1212.21h1_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"

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
