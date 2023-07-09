
data "archive_file" "lambda" {
  type        = "zip"
  source_file  = "code/lambda_function.py"
  output_path = "lambda.zip"
}

resource "aws_lambda_function" "lambda_function" {
  code_signing_config_arn = ""
  description             = ""
  filename                = data.archive_file.lambda.output_path
  function_name           = "${var.project_name}-lambda-function"
  role                    = aws_iam_role.iam_role.arn
  handler                 = "lambda_function.lambda_handler"
  runtime                 = "python3.7"
  source_code_hash        = filebase64sha256(data.archive_file.lambda.output_path)

  vpc_config {
    subnet_ids         = [var.private_subnetid]
    security_group_ids = [var.security_group_id]
  }
}

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
  name               = "ganesh-iam-role-lambda-trigger"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_vpc_access_execution" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

}