# Terraform AKS Module

This module creates an AKS cluster following the best practices defined by the SRE/Cloud team at Stone CO.

## Requirements

- Terraform version 1.11
- Azurerm Provider version 1.23+ (tested on version 1.23.0)

## How to use

The following parameters are expected:
- ``resource_group_name``: All resources in this module will be created in this resource group. Ex: Infrastructure-Common-EC2-DEV
- ``location_name``: The Azure region in which this cluster will be created. Ex: Central US or East US 2
- ``name_suffix``: The suffix of the AKS clusters that will be created. Is recommended to include: trible, region and environment. It will be prefixed by a generic name 'Main' and the network that it uses. Ex: Main-DMZ-FIN-EC2-STG
- ``subnet_rg_name``: The resource group of the cluster subnet.
- ``subnet_vnet_name``: The VNet of the cluster subnet
- ``subnet_dmz_name``: The subnet in which the DMZ cluster will be created. All subscriptions already come with subnets reserved for AKS.
- ``subnet_inside_name``: The subnet in which the Inside cluster will be created. All subscriptions already come with subnets reserved for AKS.
- ``ad_client_app_id``: The Client ID of an Azure Active Directory Application that will be used to activate AD based authentication on the cluster
- ``ad_server_app_id``: The Server ID of the above AD application
- ``ad_tennant_id``: The Tenant ID of the above AD application
- ``ad_server_app_secret``: The Client Secret of the above AD application
- ``service_principal_app_id``: The appId of the service principal that will be used by the cluster to interact with Azure
- ``service_principal_password``: The password of the service principal above
- ``vm_size``: Specifies the size of the Virtual Machine. The default value is "Standard_D2_v3", only specifies if needs to be changed.
- ``kubernetes_version``: Specifies Kubernetes version. The default value is "1.13.5", only specifies if needs to be changed.
- ``node_count``: Specifies Cluster's number of nodes . The default value is "2", only specifies if needs to be changed.

With all that defined, just call it in your configuration

```hcl
module "aks" {
  source = "git@github.com:stone-payments/terraform-aks.git?ref=v1.0.0" # see tags for available versions

  resource_group_name =        ""
  location_name =              ""
  name_suffix =                ""
  subnet_rg_name =             ""
  subnet_vnet_name =           ""
  subnet_dmz_name =            ""
  subnet_inside_name =         ""
  ad_client_app_id =           ""
  ad_server_app_id =           ""
  ad_tennant_id =              ""
  ad_server_app_secret =       ""
  service_principal_app_id =   ""
  service_principal_password = ""
  default_node_size =          ""
  kubernetes_version =         ""
  default_node_count =         ""
  os_disk_size_gb =            "" 
  default_node_enable_auto_scaling  = ""
  default_node_max_count =     ""
  default_node_min_count =     ""
  default_node_max_pods  =     ""
  default_node_count     =     ""
}
```

The following outputs are generated:
- ``ins_kube_config_raw``: Inside cluster kubeconfig file(as text) that allows login as cluster admin
- ``dmz_kube_config_raw``: DMZ cluster kubeconfig file(as text) that allows login as cluster admin

## Contributing

Contributions of all forms are welcome. Just open a new issue or pull request.

