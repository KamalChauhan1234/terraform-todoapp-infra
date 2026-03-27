variable "rg_name" {}
variable "location" {}
variable "app_service_plan" {
    description = "App Service Plan Name"
    type        = string
}

variable "runtime_stack" {
  description = "Runtime stack for app"
  type        = string
}
variable "app_name" {
    description = "Name of the Web App"
    type        = string
}

variable "sql_server_name" {
    default = null
}
variable "sql_admin_username" {
    default = null
}
variable "sql_admin_password" {
    default = null
} 
variable "sql_database_name" {
    default = null
}
variable "tags" {}
variable "enable_db" {
  type    = bool
  default = false
}