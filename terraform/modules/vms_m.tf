# creating the web server 1
resource "azurerm_virtual_machine" "websrv1" {
  name = "websrv1"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_nic[0].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

  storage_os_disk {
    name              = var.websrv_os_disk_name[0]
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
    computer_name  = var.srv_vmname[0]
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# creating the web server 2
resource "azurerm_virtual_machine" "websrv2" {
  name = "websrv2"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_nic[1].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

# creating the os disk
  storage_os_disk {
    name              = var.websrv_os_disk_name[1]
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
    computer_name  = var.srv_vmname[1]
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# creating the web server 3
resource "azurerm_virtual_machine" "websrv3" {
  name = "websrv3"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_nic[2].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

# creating the os disk
  storage_os_disk {
    name              = var.websrv_os_disk_name[2]
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
    computer_name  = var.srv_vmname[2]
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# creating the postgres server
resource "azurerm_virtual_machine" "postgressqlsrv" {
  name = "postgsrv"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.postgres_nic[0].id]
  vm_size = "Standard_B1ms"

# creating the os disk
  storage_os_disk {
    name              = var.postgressrv_os_disk_name[0]
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
    computer_name  = var.srv_vmname[2]
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

