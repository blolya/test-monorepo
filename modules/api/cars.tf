resource "aws_apigatewayv2_integration" "integration_cars" {
  api_id                    = aws_apigatewayv2_api.api.id
  integration_type          = "AWS_PROXY"
  connection_type           = "INTERNET"
  description               = "Lambda cars"
  integration_method        = "POST"
  integration_uri           = var.invoke_arn_cars
  payload_format_version    = "2.0"
}

resource "aws_apigatewayv2_route" "route_cars" {
  api_id    = aws_apigatewayv2_api.api.id
  authorization_type = "CUSTOM"
  authorizer_id = aws_apigatewayv2_authorizer.authorizer.id
  route_key = "POST /cars"

  target = "integrations/${aws_apigatewayv2_integration.integration_cars.id}"
}

resource "aws_lambda_permission" "cars_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "cars"
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
