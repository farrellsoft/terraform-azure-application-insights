
module "loganalytics" {
  source  = "app.terraform.io/Kyndryl-CIO/loganalytics/azurerm"
  version = "0.0.3"

  for_each                  = local.log_analytics_workspaces

  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  sku                   = each.value.sku
  retention_in_days     = each.value.retention_days
  required_tags         = {}
  additional_tags       = {}
  application           = each.value.application
  purpose               = each.value.purpose
  environment           = each.value.environment
  instance              = each.value.instance
}

resource azurerm_application_insights this {
  for_each                  = var.application_insights

  name                = "appi-${each.value["application"]}-${each.value["purpose"]}${each.value["environment"]}${module.regioncodes.region_codes[lower(replace(each.value["location"], " ", ""))]}${each.value.instance == "" ? "" : "${each.value.instance}"}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  workspace_id        = module.loganalytics.law_workspace_id.0
  application_type    = "web"
}