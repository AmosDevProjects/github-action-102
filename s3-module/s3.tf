resource "aws_s3_bucket" "bucket" {
  bucket = "${var.team}-${random_pet.bucket_name.id}-${random_integer.bucket_int.result}"

  tags = {
    Name        = var.my_bucket
    Environment = var.env
  }
}

resource "random_pet" "bucket_name" {
  prefix = "wemadevops"
  length = 2
}

resource "random_integer" "bucket_int" {
  max = 500
  min = 1
}

# Release 2
resource "aws_sns_topic" "topic" {
  name   = var.topic_name
  policy = data.aws_iam_policy_document.topic.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  topic {
    topic_arn     = aws_sns_topic.topic.arn
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".log"
  }
}

# Added SNS topic
resource "aws_sns_topic_subscription" "email" {
  endpoint  = "amos.egonmwan@hotmail.com"
  protocol  = "email"
  topic_arn = aws_sns_topic.topic.arn
}