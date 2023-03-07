Modular version of analytics service

# MODULAR VERSION OF ANALYTICS SERVICE

The modular analytics service is used to integrate a mongoDb where information regarding statistical data will be saved. 
The service consists of a sqs queue to which the external service can send data. With each message a lambda is triggered and processes the messages and then writes them to the mongoDb.

##### Prerequisites
Install node (npm), node version manager (nvm), terraform, aws cli, and configure aws profile credentials.
Node Get Started guide to https://nodejs.org/en/download/
Node Version Manager Get Started guide to https://heynode.com/tutorial/install-nodejs-locally-nvm/
Terraform Get Started guide to https://learn.hashicorp.com/collections/terraform/aws-get-started
Terraform Get Started guide to https://terragrunt.gruntwork.io/docs/getting-started/quick-start/
AWS cli Get Started guide to https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
Stages are: dev = "development", int = "integration", prd = "production"


env.template in root/docker specify environment to set in .env file following env.template example.