resource "aws_apigatewayv2_api" "api" {
  name          = "http-test-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://test-site-5f0542.webflow.io"]
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["content-type"]
    max_age = 300
  }
}

resource "aws_apigatewayv2_stage" "api" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "api"
  auto_deploy = true
}
