
resource "aws_lambda_function" "trucks" {
  function_name    = "trucks"
  handler          = "src/functions/trucks/index.handler"
  runtime          = "nodejs18.x"
  filename         = "./lambdas/.serverless/trucks.zip"
  source_code_hash = filebase64sha256("./lambdas/.serverless/trucks.zip")
  role             = aws_iam_role.iam_for_lambda.arn
}
