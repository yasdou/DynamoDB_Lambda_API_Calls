data "archive_file" "lambda" {
  type        = "zip"
  source_file = "getitems.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "getRMdata" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "getRMdata"
  create_role   = false
  role          = aws_iam_role.LabRole.arn

  runtime = "python3.9"

  environment {
    variables = {
      foo = "bar"
    }
  }
}