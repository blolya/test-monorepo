
resource "aws_lambda_function" "trucks" {
  function_name    = "trucks"
  handler          = "src/functions/trucks/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/trucks.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/trucks.zip")
  role             = var.role_arn
}

output "invoke_arn_trucks" {
  value = aws_lambda_function.trucks.invoke_arn
}
