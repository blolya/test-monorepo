
resource "aws_lambda_function" "cars" {
  function_name    = "cars"
  handler          = "src/functions/cars/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/cars.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/cars.zip")
  role             = var.role_arn
}

output "invoke_arn_cars" {
  value = aws_lambda_function.cars.invoke_arn
}
