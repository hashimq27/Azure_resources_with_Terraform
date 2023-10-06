output "name" {
    value=[for x in local.student_names: x]
}

output "appgateway" {
    value=[for x in local.gateways: x]
}

output "linuxapp" {
    value=[for x in local.linux_app_list: x]
}