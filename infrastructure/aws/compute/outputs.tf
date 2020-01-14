output "url" {
  value = "http://${aws_alb.web_alb.dns_name}/"
}