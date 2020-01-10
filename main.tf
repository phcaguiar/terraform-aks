
data "azurerm_subnet" "aks_inside" {
  resource_group_name = "${var.network_resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
  name = "${var.subnet_inside_name}"
}

data "azurerm_subnet" "aks_dmz" {
  resource_group_name = "${var.network_resource_group_name}"
  virtual_network_name = "${var.virtual_network_name}"
  name = "${var.subnet_dmz_name}"
}

locals {
  aks_networks = [
    # {id = "${data.azurerm_subnet.aks_inside.id}", prefix = "INS"},
    {id = "${data.azurerm_subnet.aks_dmz.id}", prefix = "DMZ"}
  ]
}

# resource "azurerm_log_analytics_workspace" "aks-log-analytics-workspace" {
#     count               = "${var.has_dmz_cluster ? length(local.aks_networks) : 1}"

#     name                = "AKS-Main-${lookup(local.aks_networks[count.index], "prefix")}-${var.name_suffix}-Metrics${var.log_workspace_suffix}"
#     location            = "eastus" # It is not available in our regions
#     resource_group_name = "${var.resource_group_name}"
#     sku                 = "Standalone"
#     retention_in_days   = 40 # minimum possible, adjust for each project
# }

resource "azurerm_kubernetes_cluster" "aks" {
  count               = "${var.has_dmz_cluster ? length(local.aks_networks) : 1}"

  name                = "Main-${lookup(local.aks_networks[count.index], "prefix")}-${var.name_suffix}"
  location            = "${var.location_name}"
  dns_prefix          = "api-main-${lookup(local.aks_networks[count.index], "prefix")}-${var.name_suffix}"
  resource_group_name = "${var.resource_group_name}"
  kubernetes_version = "${var.kubernetes_version}"

  default_node_pool {
    name                = "default"
    vm_size             = "${var.default_node_size}"
    os_disk_size_gb     = "${var.default_node_os_disk_size_gb}"
    enable_auto_scaling = "${var.default_node_enable_auto_scaling}"
    type                = "VirtualMachineScaleSets"
    node_count          = "${var.default_node_count}"
    max_count           = "${var.default_node_max_count}"
    min_count           = "${var.default_node_min_count}"
    max_pods            = "${var.default_node_max_pods}"
    # count               = "${var.default_count}"
    vnet_subnet_id = "${lookup(local.aks_networks[count.index], "id")}"
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      client_app_id = "${var.ad_client_app_id}"
      server_app_id = "${var.ad_server_app_id}"
      server_app_secret = "${var.ad_server_app_secret}"
      tenant_id = "${var.ad_tennant_id}"
    }
  }

  # addon_profile {
  #   oms_agent {
  #     enabled = true
  #     log_analytics_workspace_id = "${azurerm_log_analytics_workspace.aks-log-analytics-workspace.*.id[count.index]}"
  #   }
  # }

  service_principal {
    client_id     = "${var.service_principal_app_id}"
    client_secret = "${var.service_principal_password}"
  }

  network_profile {
    network_plugin = "azure"
    docker_bridge_cidr = "192.168.128.1/17" # arbitrary, must be customized to avoid conflicts with our datacenters networks
    service_cidr = "192.168.0.0/17" # arbitrary, must be customized to avoid conflicts with our datacenters networks
    dns_service_ip = "192.168.0.10"
    load_balancer_sku = "${var.load_balancer_sku}"
  }
}
