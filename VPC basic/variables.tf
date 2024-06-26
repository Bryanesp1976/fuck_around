variable "base_name" {
  type    = string
  default = "test"
  description = "Used to generate a unique and easy to identify name for each resource that is created."
}

variable "region" {
  type    = string
  default = "us-east-1"
  description = "This is the single region all AWS resources will be deployed to."
}

variable "generic_tag_notes" {
  type    = string
  default = "Created using Terraform code pulled from the Innovation launchpad building blocks repository."
  description = "Used to generate a unique and easy to identify set of notes that gets tagged for each resource that is created."
}