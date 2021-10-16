
variable "resource_group" {
    default = "week5-basic-project"
}

variable "location" {
    default = "eastus2"
}

variable "vnet" {
    default = "srvs_vnet"
}

variable "address_space" {
    default = "10.0.0.0/16"
}

variable "subnet_prefix" {
    type    = list
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "websrv_nic_name" {
    type = list(string)
    default = ["webSrv1_nic","webSrv2_nic","webSrv3_nic"]
}

variable "postgressrv_nic_name" {
    type = list(string)
    default = ["sqlserversrv_nic"]
}

variable "websrv_ip_internal_name"{
    type = list(string)
    default = ["webSrv1_internal_ip","webSrv2_internal_ip","webSrv3_internal_ip"]
}

variable "postgressrv_ip_internal_name"{
    type = list(string)
    default = ["postgressrv_inetrnal_ip"]
}

variable "ip_public_name"{
    type = list(string)
    default = ["webSrv1_public_ip","webSrv2_public_ip","webSrv3_public_ip"]
}

variable "LB_ip_conf_name" {
    type = list(string)
    default = ["webSrv1_ip_conf_name","webSrv2_ip_conf_name","webSrv3_ip_conf_name"]
}

variable "availability_set_name"{
    default = "avset_websrvs"
}

variable "srv_vmname"{
    type = list(string)
    default = ["webSrv1","webSrv2","webSrv3"]
}

variable "srvvm_size"{
    default = "Standard_B1ls"
}

variable "os_disk_name" {
    type = list(string)
    default = ["webSrv1_osdisk1","webSrv2_osdisk","webSrv3_osdisk"]
}

variable "managed_disk_type" {
    default = "StandardSSD_LRS"
}

variable "nsg_dst_port_num_websrvs" {
  type = list(string)
  default = ["22","8080"]
}

variable "nsg_rule_name_websrvs" {
  type = list(string)
  default = ["SSH", "TCP_8080"]
}

/* variable "nsg_rule_name_postgressrvs" {
  type = list(string)
  default = ["SSH", "TCP_5432"]
}

variable "nsg_dst_port_num_postgressrvs" {
  type = list(string)
  default = ["22","5432"]
} */