output "name" {
    value=[for x in locals.student_names: student]
}