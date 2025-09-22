variable "vsphere_server" {
  type    = string
  default = ""
}

variable "vsphere_user" {
  type    = string
  default = ""
}

variable "vsphere_password" {
  type    = string
  default = ""
}

variable "datacenter" {
  type    = string
  default = ""
}

variable "cluster" {
  type    = string
  default = ""
}

variable "datastore" {
  type    = string
  default = ""
}

variable "network_name" {
  type    = string
  default = ""
}

variable "autounattend_file" {
  type    = string
  default = ""
}

variable "os_iso_checksum" {
  type    = string
  default = ""
}

variable "os_iso_url" {
  type    = string
  default = ""
}

variable "vmtools_iso_path" {
  type    = string
  default = ""
}

variable "floppy_pvscsi" {
  type = string
  default = ""
}

variable "winrm_username" {
  type        = string
  description = "The username to login to the guest operating system."
  sensitive   = true
}

variable "winrm_password" {
  type        = string
  description = "The password to login to the guest operating system."
  sensitive   = true
}

