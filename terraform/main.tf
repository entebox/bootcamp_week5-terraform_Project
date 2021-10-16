 # Create resource group for the env
 resource   "azurerm_resource_group" "rg"   { 
   name   =   var.resource_group 
   location   =   var.location 
 } 

# Create virtual network for the VMs
 resource   "azurerm_virtual_network" "vmservers_network"   { 
   name   =   var.vnet
   address_space   =   [ var.address_space ] 
   location   =   var.location
   resource_group_name   =   var.resource_group
   depends_on = [ azurerm_resource_group.rg ]
 } 

# Create the subnets for the env
 resource   "azurerm_subnet" "subnet"   { 
   name   =   var.subnet_name[count.index]
   resource_group_name   =    var.resource_group 
   virtual_network_name   =   var.vnet
   address_prefix   =    var.subnet_prefix[count.index]
   depends_on = [ azurerm_virtual_network.vmservers_network ]
   count = length(var.subnet_name)
 } 

# Create the NICs for the websrv VMs
resource "azurerm_network_interface" "web_nic" {
  name                = var.websrv_nic_name[count.index]
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name = var.websrv_ip_internal_name[count.index]
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.subnet[0].id
    public_ip_address_id = azurerm_public_ip.webpublicip[count.index].id
  }
  count = length(var.websrv_nic_name)
}

# Create the NICs for the postgressrv VMs
resource "azurerm_network_interface" "postgres_nic" {
  name                = var.postgressrv_nic_name[count.index]
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name = var.postgressrv_ip_internal_name[count.index]
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.subnet[1].id
  }
  count = length(var.postgressrv_nic_name)
}

# Create the public ip for the web VMs
 resource   "azurerm_public_ip" "webpublicip"   { 
   name   =   var.ip_public_name[count.index] 
   location   =   var.location 
   resource_group_name   =   var.resource_group
   allocation_method   =   "Dynamic" 
   sku   =   "Basic"
   count = length(var.ip_public_name) 
 } 

 # Create the public ip for the LB
 resource   "azurerm_public_ip" "LBpublicip"   { 
   name   =   "loadBalancer_Pub_ip" 
   location   =   var.location 
   resource_group_name   =   var.resource_group
   allocation_method   =   "static" 
   sku   =   "Basic"
 }

 # creating the load balancer
 resource "azurerm_lb" "Websrv_LB" {
  name                = "WebLoadBalancer"
  location            = var.location
  resource_group_name = var.resource_group

  frontend_ip_configuration {
    name                 = "LBPublicIPAddress"
    public_ip_address_id = azurerm_public_ip.LBpublicip.id
  }
 }

 # creating the load balancer backend address pool
 resourse "azurerm_lb_backend_address_pool" "backend_add_pool" {
  loadbalancer_id = azurerm_lb.Websrv_LB.id
  name            = "BackEndAddressPool"
 }

# creating the load balancer backend address pool association to the nics of the web servers
resource "azurerm_network_interface_backend_address_pool_association" "websrvs_nic_asso"{
        network_interface_id    = azurerm_network_interface.web_nic[count.index].id
        ip_configuration_name   = var.LB_ip_conf_name[count.index]
        backend_address_pool_id = azurerm_lb_backend_address_pool.backend_add_pool.id
        count = length(var.LB_ip_conf_name)
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "NSG_for_websrvs" {
    name                = "nsg_for_websrvs_subnet"
    location            = var.location
    resource_group_name = var.resource_group
}

# create NSG rules for web servers
resource "azurerm_network_security_rule" "NS_rules_for_websrvs" {
        name                       = var.nsg_rule_name_websrvs[count.index]
        priority                   = "(100 * (${count.index} + 1))" # priority iteration
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = var.nsg_dst_port_num[count.index] # destination port for each rule
        source_address_prefix      = var.nsg_source_ip
        destination_address_prefix = "*"
        count = length(var.nsg_rule_name_websrvs)
}

/* resource "azurerm_network_security_group" "NSG_for_postgressrv" {
    name                = "nsg_for_postgressrvs_subnet"
    location            = var.location
    resource_group_name = var.resource_group
}

resource "azurerm_network_security_rule" "NS_rules_for_postgressrv" {
        
        name                       = var.nsg_rule_name_postgressrvs[count.index]
        priority                   = "(100 * (${count.index} + 1))"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = var.nsg_dst_port_num[count.index]
        source_address_prefix      = var.nsg_source_ip
        destination_address_prefix = "*"
        count = length(var.nsg_rule_name_postgressrvs)
} */

# associate the web servers subnet to the NSG (instead of creating nsg for each VM) 
resource "azurerm_subnet_network_security_group_association" "sub_nsg_asso_for_websrvs" {
  subnet_id                 = azurerm_subnet.subnet[0].id # 0 for frontend subnet
  network_security_group_id = azurerm_network_security_group.NSG_for_websrvs.id
}

/* resource "azurerm_subnet_network_security_group_association" "sub_nsg_asso_for_postgressrv" {
  subnet_id                 = azurerm_subnet.subnet[1].id # 1 for backend subnet
  network_security_group_id = azurerm_network_security_group.NSG_for_postgressrv.id
} */

 /* resource "azurerm_availability_set" "avset" {
   name                = var.availability_set_name
   location            = var.location
   resource_group_name = var.resource_group
 } */

# creating the web server 1
resource "azurerm_virtual_machine" "websrv1" {
  name = "websrv1"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.web_nic[0].id]
  #availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

  storage_os_disk {
    name              = var.os_disk_name[0]
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
  #availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

# creating the os disk
  storage_os_disk {
    name              = var.os_disk_name[1]
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
  #availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

# creating the os disk
  storage_os_disk {
    name              = var.os_disk_name[2]
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
  name = "postgressqlsrv"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [azurerm_network_interface.postgres_nic[0].id]
  #availability_set_id   = azurerm_availability_set.avset.id
  vm_size = var.srvvm_size

# creating the os disk
  storage_os_disk {
    name              = var.os_disk_name[2]
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

