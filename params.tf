
variable application_insights {
  type          = map(object({
    resource_group_name               = string
    application                       = string
    purpose                           = optional(string, "")
    environment                       = string
    instance                          = optional(string, "")
    location                          = string
    log_analytics_sku                 = optional(string, "PerGB2018")
    retention_days                    = optional(number, 30)
  }))
  description   = "Application Insights"
}