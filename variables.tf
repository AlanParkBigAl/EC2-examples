variable "aws_region" {
  description = "Region for deployment"
  type        = string
  default     = "ap-southeast-2"
}

variable "budget_alert_email" {
  description = "Email for cost alerts"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance size"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your IP in CIDR notation, for SSH access (e.g. 1.2.3.4/32)"
  type        = string
}

variable "key_pair_name" {
  description = "Name of an EXISTING EC2 key pair created in AWS console"
  type        = string
}
