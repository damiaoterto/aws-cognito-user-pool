resource "aws_cognito_user_pool" "auth-user-pool" {
  name = "${var.environment}-${var.app_name}-user-pool"

  mfa_configuration = "OFF"

  schema {
    attribute_data_type = "DateTime"
    name = "is_activated"
    required = false
  }

  username_attributes = [
    "email",
    "phone_number"
  ]

  password_policy {
    minimum_length = 8
    require_lowercase = true
    require_numbers = true
    require_symbols = false
    require_uppercase = false
  }
}

resource "aws_cognito_user_pool_client" "auth-user-pool-client" {
  name = "${var.environment}-${var.app_name}-user-pool"
  user_pool_id = aws_cognito_user_pool.auth-user-pool.id

  generate_secret = false

  explicit_auth_flows = ["USER_PASSWORD_AUTH"]
}

resource "aws_cognito_user_group" "auth-admin-group" {
  name = "admin"
  description = "Admin users"
  user_pool_id = aws_cognito_user_pool.auth-user-pool.id
}

resource "aws_cognito_user_group" "auth-common-group" {
  name = "common"
  description = "Common users"
  user_pool_id = aws_cognito_user_pool.auth-user-pool.id
}
