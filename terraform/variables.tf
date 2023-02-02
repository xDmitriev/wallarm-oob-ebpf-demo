variable "subscription_id" {
  default = "ef8d68e3-3507-49d5-8672-194c86853309"
}

variable "name_prefix" {
  default = "ebpf-demo"
}

variable "location" {
  default = "East Asia"
}

variable "node_count" {
  default = 2
}

variable "kubernetes_version" {
  default = "1.25.4"
}

variable "wallarm_api_token" {}

variable "wallarm_api_host" {}

variable "app_namespace" {
  default = "myapp"
}

variable "app_host" {
  default = "ebpf-demo.com"
}