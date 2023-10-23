# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags on Git](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Locall delete a tag
```sh
git tag -d <tag_name>
```

Remotely delete tag

```sh
git push --delete origin tagname
```

Checkout the commit that you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
├── variables.tf      # stores the structure of input variables
├── providers.tf      # defined required providers and their configurations
├── outputs.tf        # stores the outputs
├── terraform.tfvars  # the data of variables we want to load into our terraform project.
├── main.tf           # everything else
└── README.md         # required for root modules
```

Manually generate the files using the following commands. 

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

### Terraform Cloud Variables

In terraform, we can set two kinds of variables:
- Environmental variables: those you set in your bash terminal such as AWS credentials.
- Terraform variables: those that you normally set in your `tfvars` file. 

We can set Terraform Cloud variables to be sensitive so they are not visibly displayed in the UI. 

### Loading Terraform Input Variables

### [`-var` flag](https://developer.hashicorp.com/terraform/language/values/variables#variables-on-the-command-line)

We can use the `-var` flag to set an input variable or override a variable in the `tfvars` file such as `terraform -var user_uuid=0000-...`  

This will override the pre-defined varible in other files. 

```
terraform apply -var="user_uuid=hell_user_uuid1234567"
```
### [`-var-file` flag](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files)

If you have multiple variables that you have to use on the fly in the command lines, it is more convenient to feed them in bulk. Define all the variables in a single file (either in `.tfvars` or `.tfvars.json`), then specify the file path as the valu for the `-var-file` flag.

```
terraform apply -var-file="bulkvalues.tfvars"
```

### [`terraform.tfvars`](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files)

This is the default file to load in terraform variables in bulk.

### `auto.tfvars`

Terraform automatically loads a number of variable definitions files if they are present. This list also indicates the precedence of files from top to bottom and from left to right: 

- Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
- Any files with names ending in `.auto.tfvars` or `.auto.tfvars.json`
- Files named exactly `terraform.tfvars.json` or `terraform.tfvars`

<br>

### order of terraform variables

- TODO: document which terraform variables takes presendence.

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```
## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Static Website Hosting

### Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or data about Terraform. 

It may likely produce older or deprecated examples, often affecting `providers`.

### Considerations when using Terraform to manage different types of resources

In this bootcamp, we are using Terraform for all three types of management:
- Infrastructure (resources management)
- Configurations
- Files

Please note that Terraform is optimised and made for infrastructure management. Therefore, managing files (uploading and downloading) using terraform is not the best practice, all the more so in production environment although Terraform does offer the capabilities to perform such tasks.

### Working with Files in Terraform 

#### [Fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists) function
This is a built in terraform function to check the existance of a file.

```
condition = fileexists(var.error_html_filepath)
```

#### [Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)


#### Path variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- `path.module` = get the path for the current module
- `path.root` = get the path for the root module

```sh
resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.website_bucket.bucket
    key = "index.html"
    source = var.index_html_filepath
    etag = filemd5("${path.root}/public/index.html")

```

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terraform Data Sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)