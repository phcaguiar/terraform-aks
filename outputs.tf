output "has_dmz_cluster" {
    value = "${var.has_dmz_cluster}"
}

output "aks_id" {
    value = "${azurerm_kubernetes_cluster.aks.*.id[0]}"
}

# output "ins_kube_config_raw" {
#     value = "${azurerm_kubernetes_cluster.aks.*.kube_admin_config_raw[0]}"
#     sensitive = true
# }
# output "dmz_kube_config_raw" {
#     value = "${var.has_dmz_cluster ? azurerm_kubernetes_cluster.aks.*.kube_admin_config_raw[1] : ""}"
#     sensitive = true
# }