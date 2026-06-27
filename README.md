[200~# Section 3: EC2 Fundamentals - Terraform Lab

Companion Terraform build for Section 3 (EC2 Fundamentals) of Stephane Maarek's
AWS SAA-C03 course. Each console-based lab in the section was first done manually
in the AWS console, then rebuilt here in Terraform.

## What this provisions

- EC2 instance (web-server-tf) - Amazon Linux 2023, AMI looked up dynamically
  via data "aws_ami" rather than hardcoded, bootstrapped with user_data to
  install and start Apache, serving a test page on launch
- Security group (web-sg-tf) - SSH restricted to a single IP (the operator's),
  HTTP open to 0.0.0.0/0, all egress allowed
- IAM role + instance profile (DemoRoleForEC2-tf) - attached to the EC2
  instance with IAMReadOnlyAccess, demonstrating EC2 service roles rather than
  embedding credentials on the instance
- Spot instance request - same AMI/security group, requested at a max price
  of $0.01/hr, to compare against the on-demand instance's behavior and cost
- AWS Budget (monthly-cost-guard-tf) - $5/month limit with alerts at 80%
  actual spend and 100% forecasted spend, as a safety net across the account

## Verification

Instance reachable and serving traffic via the user_data bootstrap:

  curl http://3.26.2.3
  Hello from ip-172-31-30-187.ap-southeast-2.compute.internal, deployed via Terraform

Both instances passed all status checks (2/2) in the AWS console, confirmed
alongside the security group's scoped inbound rules and the fulfilled spot
request (instance type t3.micro, $0.010 max price).

## Security notes

- No secrets committed: terraform.tfvars and terraform.tfstate are gitignored
- SSH key pair (my-ec2-key) created manually in the AWS console, referenced
  here only by name, since generating it via Terraform would write the
  private key into state in plaintext
- SSH access scoped to a single IP via var.my_ip, not open to the internet

## Teardown

  terraform destroy

All resources (instance, spot request, security group, IAM role, instance
profile, budget) are torn down after each session to avoid ongoing cost.
