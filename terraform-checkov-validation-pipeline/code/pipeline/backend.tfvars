bucket         = "bryan-tf-bucket"  #terraform state bucket name from step 1, from  state folder variables.tf file
key            = "state/terraform.tfstate" #example - infra_validation_pipeline/terraform.tfstate
region         = "us-east-1"
dynamodb_table = "bryan-terraform-state-lock" #terraform locks DynamoDB table name from step 1, from  state folder variables.tf file
