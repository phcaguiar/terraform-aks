variable "resource_group_name" {}

variable "location_name" {}

variable "name_suffix" {}

variable "has_dmz_cluster" {
    description = "If true, the module will declare the AKS DMZ cluster resources. Otherwise they won't be created."
    default = true
}

variable "log_workspace_suffix" {
    description = "Suffix to be appended to Log Analytics Workspace, to avoid name colisions."
    default = ""
    # See https://github.com/MicrosoftDocs/azure-docs/issues/35143
}

variable "network_resource_group_name" {}

variable "virtual_network_name" {}

variable "subnet_dmz_name" {}

variable "subnet_inside_name" {}

variable "ad_client_app_id" {}

variable "ad_server_app_id" {}

variable "ad_tennant_id" {}

variable "ad_server_app_secret" {}

variable "service_principal_app_id" {}

variable "service_principal_password" {}

variable "default_node_size" {
    default = "Standard_D2_v3"
}

variable "node_count" {
    default = "1"
}

variable "kubernetes_version" {
    default = "1.15.7"
}

variable "default_node_os_disk_size_gb" {
  default = "50"
}

variable "default_node_enable_auto_scaling" {
  default   =   "true"
}
variable "default_node_count" {
  default   =   "1"
}
variable "default_node_max_count" {
  default   =   "10"
}
variable "default_node_min_count" {
  default   =   "1"
}
variable "default_node_max_pods" {
  default   =   "10"
}
variable "load_balancer_sku" {
  default   =   "standard"
}
