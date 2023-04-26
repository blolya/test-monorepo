resource "aws_api_gateway_resource" "resource_cars" {
  path_part   = "cars"
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_method" "method_cars" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_cars.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "rest_api_get_method_response_200_cars" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource_cars.id
  http_method   = aws_api_gateway_method.method_cars.http_method
  status_code   = "200"
}

resource "aws_api_gateway_integration" "integration_cars" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource_cars.id
  http_method             = aws_api_gateway_method.method_cars.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.invoke_arn_cars
}

resource "aws_lambda_permission" "apigw_lambda_cars" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "cars"
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.method_cars.http_method}${aws_api_gateway_resource.resource_cars.path}"
}

resource "aws_api_gateway_deployment" "rest_api_deployment_cars" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.resource_cars.id,
      aws_api_gateway_method.method_cars.id,
      aws_api_gateway_integration.integration_cars.id
    ]))
  }
}

resource "aws_api_gateway_stage" "rest_api_stage_cars" {
  deployment_id = aws_api_gateway_deployment.rest_api_deployment_cars.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.api_stage_name
}
