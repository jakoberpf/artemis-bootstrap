resource "local_file" "user_data" {
  count = length(var.nodes)
  content = templatefile("${path.module}/templates/user-data.tpl",
    {
      id              = var.nodes[count.index].id
      authorized_keys = var.authorized_keys
      username        = var.default_user
      password        = var.default_password
    }
  )
  filename = "${path.root}/../nodes/${var.nodes[count.index].id}/user-data"
}

resource "local_file" "network_config" {
  count = length(var.nodes)
  content = templatefile("${path.module}/templates/network-config.tpl",
    {
      id = var.nodes[count.index].id
      ip = var.nodes[count.index].ip
    }
  )
  filename = "${path.root}/../nodes/${var.nodes[count.index].id}/network-config"
}
