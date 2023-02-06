
module "loganalytics" {
  source  = "app.terraform.io/Kyndryl-CIO/loganalytics/azurerm"
  version = "0.0.3"

  log_analytics = local.log_analytics_workspaces
}

resource azurerm_application_insights this {
  for_each                  = var.application_insights

  name                = "appi-${each.value["application"]}-${each.value["purpose"]}${each.value["environment"]}${module.regioncodes.region_codes[lower(replace(each.value["location"], " ", ""))]}${each.value.instance == "" ? "" : "${each.value.instance}"}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  workspace_id        = module.loganalytics.law_workspace_id.0
  application_type    = "web"
}