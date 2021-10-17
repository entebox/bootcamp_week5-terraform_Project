# Create the NICs for the websrv VMs
resource "azurerm_network_interface" "web_nic" {
  name                = var.websrv_nic_name[count.index]
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = var.websrv_ip_internal_name[count.index]
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet[0].id
    public_ip_address_id          = azurerm_public_ip.webpublicip[count.index].id
  }
  count = length(var.websrv_nic_name)
}


# creating the web server 1
resource "azurerm_virtual_machine" "websrv1" {
  name                  = "websrv1"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.web_nic[0].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size               = var.srvvm_size

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
  name                  = "websrv2"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.web_nic[1].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size               = var.srvvm_size

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
  name                  = "websrv3"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.web_nic[2].id]
  availability_set_id   = azurerm_availability_set.avset.id
  vm_size               = var.srvvm_size

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