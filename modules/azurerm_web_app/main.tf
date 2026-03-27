# App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan
  location            = var.location
  resource_group_name = var.rg_name

  os_type  = "Linux"
  sku_name = "B1"
}

# Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.rg_name
  service_plan_id     = azurerm_service_plan.asp.id

site_config {
  application_stack {
    node_version   = var.runtime_stack == "node"   ? "18-lts" : null
    python_version = var.runtime_stack == "python" ? "3.10"   : null
  }
}

  app_settings = var.enable_db && var.sql_server_name != null ? {
      DB_SERVER       = var.sql_server_name
      DB_USER         = var.sql_admin_username
      DB_PASSWORD     = var.sql_admin_password
      DB_NAME         = var.sql_database_name
      DB_CONNECTION   = "Server=tcp:${var.sql_server_name}.database.windows.net,1433;Database=${var.sql_database_name};Uid=${var.sql_admin_username};Pwd=${var.sql_admin_password};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;"
  }  : {
    "WEBSITE_NODE_DEFAULT_VERSION" = "18-lts"
  }

  tags = var.tags
}