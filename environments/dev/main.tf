module "authentication" {
  source = "../../infrastructure/authentication"
  
  environment = var.environment
  app_name = var.app_name
}