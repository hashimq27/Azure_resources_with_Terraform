output "name" {
    value=[for x in local.student_names: x]
}