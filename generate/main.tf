resource "local_file" "main" {
  for_each = local.catalog

  filename        = "${path.module}/../modules/${each.key}/main.tf"
  file_permission = "0644"
  content = templatefile("${path.module}/templates/main.tf.tftpl", {
    ingress_rules = each.value.ingress_rules
  })
}

resource "local_file" "readme" {
  for_each = local.catalog

  filename        = "${path.module}/../modules/${each.key}/README.md"
  file_permission = "0644"
  content = templatefile("${path.module}/templates/README.md.tftpl", {
    name          = each.key
    display_name  = each.value.display_name
    ingress_rules = each.value.ingress_rules
  })
}

resource "local_file" "variables" {
  for_each = local.catalog

  filename        = "${path.module}/../modules/${each.key}/variables.tf"
  file_permission = "0644"
  content = templatefile("${path.module}/templates/variables.tf.tftpl", {
    ingress_rules = each.value.ingress_rules
  })
}

resource "local_file" "outputs" {
  for_each = local.catalog

  filename        = "${path.module}/../modules/${each.key}/outputs.tf"
  file_permission = "0644"
  content         = file("${path.module}/templates/outputs.tf.tftpl")
}

resource "local_file" "versions" {
  for_each = local.catalog

  filename        = "${path.module}/../modules/${each.key}/versions.tf"
  file_permission = "0644"
  content         = file("${path.module}/templates/versions.tf.tftpl")
}
