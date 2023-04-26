
resource "aws_lambda_function" "ships" {
  function_name    = "ships"
  handler          = "src/functions/ships/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/ships.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/ships.zip")
  role             = var.role_arn
}

output "invoke_arn_ships" {
  value = aws_lambda_function.ships.invoke_arn
}
