#------------------------------------------Creating the VMs------------------------------------------#
# Create the NICs for the VMs
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.vm_type}${var.modu_ind + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.vm_type == "websrv" ? "${var.vm_name}_internal_ip" : "postgres_ip_conf"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_name
  }
}

# creating the servers
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm_name}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, var.modu_ind)]
  availability_set_id   = var.vm_type == "websrv" ? var.avset : ""
  vm_size               = var.srvvm_size

  # creating the os disk
  storage_os_disk {
    name              = "osdisk-${var.vm_type}${var.modu_ind + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
  }

  storage_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_type == "websrv" ? "websrv${var.modu_ind + 1}" : "postgsrv"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}