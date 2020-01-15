resource "aws_sqs_queue" "web_queue" {
  name = "web-queue"

  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  delay_seconds = "${var.delay_seconds}"
  max_message_size = "${var.max_message_size}"
  message_retention_seconds = "${var.message_retention_seconds}"
}
