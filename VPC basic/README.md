# Basic AWS VPC - Terraform

You must be logged into the AWS Innocation Launchpad with valid AWS credentials configured as envrionment variables
for this template to work.This template will deploy a "vanilla" VPC like what you would get if you deployed a VPC 
with the NAT gateway option via the AWS console.  There are 64,000 available IP addresses with 2,000 IPs allocated per subnet.

This template consists of:
- A VPC with 2 public and 2 private subnets
- All other related components to enable the flow of network traffic and internet access from the private subnets.
- A private S3 endpoint which by default will prevent S3 traffic within the VPC from flowing over the internet.

There are no required inputs.

Optional Inputs - see the variables file for more information:
- base_name
- region
- generic_tag_notes


Created by Adam Saunders on 8/11/22, updated 11/7/22