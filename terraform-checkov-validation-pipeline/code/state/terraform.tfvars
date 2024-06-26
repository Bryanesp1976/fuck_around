region                         = "us-east-1" ##Enter you region, Gov Cloud default is us-gov-west-1"
terraform_state_bucket_name    = "bryan-tf-bucket" #Must be a unique name, s3 buckets cannot share a name since they are a global resource, you must change this value, otherwise the code will not run, recommended to replace "uniquelabel" text with something easy to identify
terraform_locks_ddb_table_name = "bryan-terraform-state-lock" #Name for your dynamodb table that holds your state lock, recommended to replace "uniquelabel" text with something easy to identify
