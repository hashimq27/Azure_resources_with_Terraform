output "name" {
    value=[for x in local.student_names: x]
}

output "gateways" {
    value=[for x in local.student_names: x]
}