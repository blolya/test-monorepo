# test-monorepo
Terraform AWS monorepo attempt

## Description
The goal is to create easy to use tool to:
* manage lambda functions (create from templates, remove, list and so on)
* automatically deploy required AWS resources (Lambdas, APIs, RDS(//TODO), etc.) with terraform

## Project structure
* bin/ - shell scripts to create/remove/list lambda functions
  * `create-lambda [NAME]` - creates lambda function with [NAME] if it doesn't already exist and adds corresponding terraform config file
  * `remove-lambda [NAME]` - removes lambda function with [NAME] and its corresponding terraform config file
  * `list-lambdas` - prints folder names from `./lambdas/src/functions` directory
* lambdas/ - contains code for lambda functions and its libraries
* modules/ - terraform modules

## How to use
1. create lambda function with `./bin/create-lambda [NAME]` script
2. edit code of newly created function in `./lambdas/src/functions/[NAME]/index.ts` file
3. bundle lambdas with `npx sls package` command  (tried bundle with webpack, but without much success)
4. apply changes to infrastructure with `terraform apply` command
