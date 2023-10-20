# Terraform Beginner Bootcamp 2023 - Week 1

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

## Resources 
- [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
- [Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)