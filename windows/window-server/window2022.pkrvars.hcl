vsphere_server = ""
vsphere_user = ""
vsphere_password = ""

datacenter = "DatacenterDEV"
cluster = "Vm-Cluster-Blade"

datastore = "ESXiTest131_dbs"

network_name = "VM Network"

vmtools_iso_path        = "[vCenterHA-dbs] vmtools/windows.iso"
floppy_pvscsi           = "[vCenterHA-dbs] floppies/pvscsi-Windows8.flp"

# Windows username (created in autounattend.xml. If you change it here the please also adjust in all autounattend.xml)
winrm_password = "vagrant"

# Windows password (created in autounattend.xml. If you change it here the please also adjust in all autounattend.xml)
winrm_username = "vagrant"
