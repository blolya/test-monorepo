resource "aws_lambda_function" "webflow-request-authorizer" {
  function_name    = "webflow-request-authorizer"
  handler          = "src/functions/webflow-request-authorizer/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/webflow-request-authorizer.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/webflow-request-authorizer.zip")
  role             = var.role_arn

  environment {
    variables = {
      WEBFLOW_AUTH_TOKEN = var.webflow_auth_token
      SITE_ID = var.site_id
    }
  }
}

output "invoke_arn_webflow-request-authorizer" {
  value = aws_lambda_function.webflow-request-authorizer.invoke_arn
}
