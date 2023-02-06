
output "application_insights" {
  value = { for k, v in azurerm_application_insights.this : k => {
    id                  = v.id
    name                = v.name
    instrumentation_key = v.instrumentation_key
  } }
  description = "The Map of the Function Apps"
}