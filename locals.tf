
locals {
  log_analytics_workspaces = {
    for k,v in var.application_insights : k => {
      resource_group_name             = v.resource_group_name
      application                     = v.application
      location                        = v.location
      purpose                         = v.purpose
      environment                     = v.environment
      instance                        = v.instance
      sku                             = v.log_analytics_sku
      retention_in_days               = v.retention_days
      required_tags                   = {
        "DataRetention"               = "true"
      }
      additional_tags                 = {}
    }
  }
}