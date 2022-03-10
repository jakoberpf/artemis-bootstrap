# Nodes
variable "nodes" {
  type = list(object({ id = string, ip = string }))
}

variable "default_user" {
  type = string
}

variable "default_password" {
  type = string
}

variable "authorized_keys" {
  type = string
}

# Zerotier
variable "zerotier_central_token" {
  type = string
}
