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
