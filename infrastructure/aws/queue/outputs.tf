output "sqs_id" {
  description = "ID of the created queue"
  value       = "${aws_sqs_queue.web_queue.id}"
}
