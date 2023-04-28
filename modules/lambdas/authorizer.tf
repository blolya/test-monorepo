resource "aws_lambda_function" "authorizer" {
  function_name    = "authorizer"
  handler          = "src/functions/authorizer/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/authorizer.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/authorizer.zip")
  role             = var.role_arn

  environment {
    variables = {
      WEBFLOW_AUTH_TOKEN = var.webflow_auth_token
      SITE_ID = var.site_id
    }
  }
}

output "invoke_arn_authorizer" {
  value = aws_lambda_function.authorizer.invoke_arn
}
