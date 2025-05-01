output "strapi_url" {
  description = "Public URL of the Strapi application served via ALB"
  value       = "http://${aws_lb.strapi_alb.dns_name}"
}




