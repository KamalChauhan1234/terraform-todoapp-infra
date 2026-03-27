locals {
  common_tags = {
    "ManagedBy"   = "Terraform"
    "Owner"       = "TodoAppTeam"
    "Environment" = "dev"
  }
}


module "rg" {
  source      = "../../modules/azurerm_resource_group"
  rg_name     = "rg-dev-todoapp-01"
  rg_location = "centralindia"
  rg_tags     = local.common_tags
}

# module "acr" {
#   depends_on = [module.rg]
#   source     = "../../modules/azurerm_container_registry"
#   acr_name   = "acrdevtodoapp015353"
#   rg_name    = "rg-dev-todoapp-01"
#   location   = "centralindia"
#   tags       = local.common_tags
# }

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp-0153"
  rg_name         = "rg-dev-todoapp-01"
  location        = "centralindia"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

# module "aks" {
#   depends_on = [module.rg]
#   source     = "../../modules/azurerm_kubernetes_cluster"
#   aks_name   = "aks-dev-todoapp"
#   location   = "centralindia"
#   rg_name    = "rg-dev-todoapp-01"
#   dns_prefix = "aks-dev-todoapp"
#   tags       = local.common_tags
# }


# module "pip" {
#   source   = "../../modules/azurerm_public_ip"
#   depends_on = [ module.rg ]
#   pip_name = "pip-dev-todoapp"
#   rg_name  = "rg-dev-todoapp-01"
#   location = "centralindia"
#   sku      = "Standard"
#   tags     = local.common_tags
# }

module "ui_webapp" {
  depends_on       = [module.resource_group]
  source           = "../../modules/azurerm_web_app"
  runtime_stack    = "node"
  enable_db        = false
  app_name         = "dev-todoapp-ui-web-kam"
  app_service_plan = "dev-todoapp-ui-asp-kam"
  rg_name          = "rg-dev-todoapp-01"
  location         = "Central India"

  tags = local.common_tags
}

module "backned_webapp" {
  depends_on         = [module.sql_database]
  source             = "../../modules/azurerm_web_app"
  runtime_stack      = "python"
  enable_db          = true
  app_name           = "dev-todoapp-backend-web-kam"
  app_service_plan   = "dev-todoapp-backend-asp-kam"
  rg_name            = "rg-dev-todoapp-01"
  location           = "Central India"
  sql_server_name    = "sql-dev-todoapp-0153"
  sql_admin_username = "devopsadmin"
  sql_admin_password = "P@ssw01rd@123"
  sql_database_name  = "sqldb-dev-todoapp"

  tags = local.common_tags
}
