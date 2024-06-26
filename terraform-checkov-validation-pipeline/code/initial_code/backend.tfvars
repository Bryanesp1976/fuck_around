bucket         = "bryan-pipeline-tf-bucket"     #terraform state bucket name,replace "uniquelabel" text with what you set it to in the previous step, the pipeline_state_bucket_name with the label you set
key            = "state/terraform.tfstate" #can leave this alone unless you want to change where the state file sits
region         = "us-east-1"
dynamodb_table = "bryan-pipeline-state-lock" #terraform locks DynamoDB table name from previous step, replace "uniquelabel" text with what you set it to in the previous step, the pipeline_locks_ddb_table_name  with the label you set