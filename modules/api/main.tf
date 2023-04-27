resource "aws_apigatewayv2_api" "api" {
  name          = "http-test-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://test-site-5f0542.webflow.io"]
    allow_methods = ["POST", "GET", "OPTIONS"]
    allow_headers = ["content-type", "user-id", "request-token"]
    max_age       = 300
  }
}

resource "aws_apigatewayv2_stage" "api" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "api"
  auto_deploy = true
}

resource "aws_apigatewayv2_authorizer" "authorizer" {
  api_id                            = aws_apigatewayv2_api.api.id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = var.invoke_arn_authorizer
  identity_sources                  = ["$request.header.user-id", "$request.header.request-token"]
  name                              = "authorizer"
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
  authorizer_result_ttl_in_seconds  = 0
}

resource "aws_lambda_permission" "authorizer_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "authorizer"
  principal     = "apigateway.amazonaws.com"

  source_arn    = "${aws_apigatewayv2_api.api.execution_arn}/authorizers/${aws_apigatewayv2_authorizer.authorizer.id}"
}
