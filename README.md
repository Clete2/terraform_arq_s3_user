A simple Terraform module to create an IAM user for use with S3 and Arq Backup

# Inputs
* `name` -> IAM user name
* `bucket_arn` -> ARN of S3 bucket to grant user access
* `bucket_prefix` -> Defaults to `/*`. Grants access to the path you specify within the bucket.
* `additional_tags` -> `map(string)` for any additional tags you want to attach in addition to the `default_tags` in the AWS Terraform provider

# Outputs
* `access_key` -> The IAM access key
* `secret_key` -> The IAM secret key

## Viewing Outputs
To view the outputs, you need to output them from the main module:

```hcl
module "my_user" {
  source = "github.com/Clete2/terraform_arq_s3_user.git"
  name   = "my-user"
}

output "my_user_access_key" {
  value     = module.my_user.access_key
  sensitive = true
}

output "my_user_secret_key" {
  value     = module.my_user.secret_key
  sensitive = true
}
```

Next, run `terraform apply`.

Finally, run `terraform output my_user_access_key` and then `terraform output my_user_secret_key`.
