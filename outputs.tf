output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}

output "web_server_public_dns" {
  value = aws_instance.web_server.public_dns
}

output "spot_instance_public_ip" {
  value = aws_spot_instance_request.spot_demo.public_ip
}
