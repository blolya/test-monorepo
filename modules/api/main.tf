resource "aws_apigatewayv2_api" "api" {
  name          = "http-test-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://test-site-5f0542.webflow.io"]
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["content-type", "user-id", "request-token"]
    max_age = 300
  }
}

resource "aws_apigatewayv2_stage" "api" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "api"
  auto_deploy = true
}

resource "aws_apigatewayv2_authorizer" "webflow_request_authorizer" {
  api_id                            = aws_apigatewayv2_api.api.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = var.invoke_arn_webflow-request-authorizer
  identity_sources                  = ["$request.header.user-id", "$request.header.request-token"]
  name                              = "webflow-request-authorizer"
  authorizer_payload_format_version = "2.0"
  enable_simple_responses = true
  authorizer_result_ttl_in_seconds = 0
#  authorizer_credentials_arn = var.role_arn
}
