region                 = "us-east-1" #deployment region
kms_key_alias          = "alias/my_kms_key" #alias/my_kms_key
kms_account_id         = "YOURACCOUNTNUMBER" ##add your AWS account number here
key_admins             = ["arn:aws:iam::351508743765:role/bryan-pipeline-role"] #specify the codebuild service role used in the pipeline, swap "aws-us-gov" to "aws" for commercial cloud, add your account# and replace the uniquelabel text with your own
log_group_name         = "bryan-test"
retention_in_days      = 365
cloudwatch_role        = "bryan-test-cw-test"
cloudwatch_role_policy = "bryan-cw-policy-test"
