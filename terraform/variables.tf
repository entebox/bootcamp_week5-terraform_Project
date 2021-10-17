#the resource group
variable "resource_group" {
    default = "week5-basic-project"
}
#the zone location
variable "location" {
    default = "eastus2"
}
#the virtual network for the servers
variable "vnet" {
    default = "srvs_vnet"
}
#the address space
variable "address_space" {
    default = "10.0.0.0/16"
}
#the subnets
variable "subnet_name" {
    type    = list(string)
    default = ["frontendSubnet", "backendSubnet"]
}
#subnet prefixes
variable "subnet_prefix" {
    type    = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}
#web servers nics
variable "websrv_nic_name" {
    type = list(string)
    default = ["webSrv1_nic","webSrv2_nic","webSrv3_nic"]
}
#postgres server nic
variable "postgressrv_nic_name" {
    type = list(string)
    default = ["postgressrv_nic"]
}
#os disk of postgres server
variable "postgressrv_os_disk_name" {
    type = list(string)
    default = ["postgressrv_os_disk"]
}
#web server internal ip name
variable "websrv_ip_internal_name"{
    type = list(string)
    default = ["webSrv1_internal_ip","webSrv2_internal_ip","webSrv3_internal_ip"]
}
#postgres server internal ip name
variable "postgressrv_ip_internal_name"{
    type = list(string)
    default = ["postgressrv_inetrnal_ip"]
}
#web servers public ip name
variable "ip_public_name"{
    type = list(string)
    default = ["webSrv1_public_ip","webSrv2_public_ip","webSrv3_public_ip"]
}
#Load balancer ip configuration name for each web servers
variable "LB_ip_conf_name" {
    type = list(string)
    default = ["webSrv1_ip_conf_name","webSrv2_ip_conf_name","webSrv3_ip_conf_name"]
}
#Load balancer frontend configuration name for public ip
variable "LB_frontend_conf_name" {
    default = "LBPublicIPAddres"
}
#availability set name
variable "availability_set_name"{
    default = "avset_websrvs"
}
#name of web servers
variable "srv_vmname"{
    type = list(string)
    default = ["webSrv1","webSrv2","webSrv3"]
}
#size of the VMs
variable "srvvm_size"{
    default = "Standard_B1ls"
}
#web servers os disk names
variable "websrv_os_disk_name" {
    type = list(string)
    default = ["webSrv1_osdisk1","webSrv2_osdisk","webSrv3_osdisk"]
}
#disk type
variable "managed_disk_type" {
    default = "StandardSSD_LRS"
}
#network security destination port number
variable "nsg_dst_port_num_websrvs" {
  type = list(string)
  default = ["22","8080"]
}
#network security rules for the web servers
variable "nsg_rule_name_websrvs" {
  type = list(string)
  default = ["SSH", "TCP_8080"]
}