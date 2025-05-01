# --- Variables ---

variable "region" {
  description = "AWS region where resources will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "strapi_image" {
  description = "Docker image URI for the Strapi container."
  type        = string
  default     = "331405041655.dkr.ecr.us-east-1.amazonaws.com/strapi-repo:latest"
}

variable "strapi_container_port" {
  description = "Port on which the Strapi container will listen."
  type        = number
  default     = 1337
}

variable "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  type        = string
  default     = "strapi-codedeploy-app"
}

variable "codedeploy_deployment_group_name" {
  description = "Name of the CodeDeploy deployment group"
  type        = string
  default     = "strapi-codedeploy-deployment-group"
}

variable "codedeploy_service_role_arn" {
  description = "ARN of the IAM role for CodeDeploy"
  type        = string
  default     = "arn:aws:iam::123456789012:role/strapi-codedeploy-role"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS Cluster"
  type        = string
  default     = "strapi-cluster"
}

variable "ecs_service_name" {
  description = "Name of the ECS Service"
  type        = string
  default     = "strapi-service"
}

variable "deployment_config_name" {
  description = "Deployment configuration name for CodeDeploy"
  type        = string
  default     = "CodeDeployDefault.ECSCanary10Percent5Minutes"
}

variable "alb_listener_arn" {
  description = "ARN of the ALB Listener"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/strapi-alb/abcdef1234567890"
}

variable "target_group_blue_name" {
  description = "Name of the blue target group"
  type        = string
  default     = "strapi-blue-tg"
}

variable "target_group_green_name" {
  description = "Name of the green target group"
  type        = string
  default     = "strapi-green-tg"
}
