
resource azurerm_log_analytics_workspace this {
  for_each                  = local.log_analytics_workspaces

  name                = "log-${each.value["application"]}-${each.value["purpose"]}${each.value["environment"]}${module.regioncodes.region_codes[lower(replace(each.value["location"], " ", ""))]}${each.value.instance == "" ? "" : "${each.value.instance}"}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  retention_in_days   =  each.value.retention_days
}

resource azurerm_application_insights this {
  for_each                  = var.application_insights

  name                = "appi-${each.value["application"]}-${each.value["purpose"]}${each.value["environment"]}${module.regioncodes.region_codes[lower(replace(each.value["location"], " ", ""))]}${each.value.instance == "" ? "" : "${each.value.instance}"}"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.this[each.key].id
  application_type    = "web"
}