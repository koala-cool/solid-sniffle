# Implementation Details

## Getting Started
When starting a new project with requirements I like to create my file structures the way I intend my code to be organized. You can get a general idea of how I had this planned by looking [at this tag](https://github.com/koala-cool/solid-sniffle/tree/0.1.0-mess). Depending on how the details of the requirements are presented, stubbing out a few files with requirements might be done too.

## Implementation
Starting with the basic building blocks, in this case the vpc, build it out in [main.tf](./main.tf). Run terraform plan making sure syntax checks out. As thigns get built in main it becomes pretty apparent if the resource is looking to be moved into it's own module for DRY's sake. Continue this loop, making adjustments to the original plans layout until the requirements are satisfied.

### Dealing with the New
Taking the Layer 7 Load Balancer as an example, it was something I had never implemented before with terraform. My first step is to lookup the [terraform docs](https://www.terraform.io/docs/providers/google/) and see if I can implement it with the info I have. If it works, take a step back, or make a note to later, to see what in GCP was created and do a little reading around what was just created and gain a basic understand of the resource. Sometimes the terraform resources tied to a request are non-obvious and google searching around will usually get me on the right path.

### Dealing with the Unexpected
Google Orginization. The free tier has 0 support for this. A lot of my original plan was intended to have a folder/project structure that is walled behind the Google Orginization requirement. I had originally also wanted to keep the network and application terraform seperate. Once I found that I would be limited to a single project I pivoted my code and plans to use a single project.

n2-standard-2 also threw me for a loop. While I quickly found out that the n2 instances are limited to certain zones. Also the n2's are limited to selected people as determined by the sales team at google. For the purpose of the demo, swapping it out to a f1-micro as a place holder will keep things moving.

## Cleanup
It's at this stage the repository gets cleaned up. Removing any temp files I might have spun off, adding files to [.gitignore](./.gitignore) that I might have missed. Giving a once over the [main.tf](./main.tf) to make sure the code flows.

## Final Testing
Cleanup might have moved resources to or out of modules. Run a final `terraform init && terraform apply`. Make any changes to the terraform state file as needed or let terraform do what it's good at.

## Documentation
Make sure documentation matches what was actually done. [This.](./README.md)

# Project Details and Notes

## Requirements
Terraform 0.12.x

## GCP Free-Tier Limitations
Without a G Suite or Cloud Identity account, the free tier of GCP does not have access to an Orginization or Folders.
https://cloud.google.com/resource-manager/docs/creating-managing-organization#acquiring

With that, a project was created manually, along side a service account for terraform.

Another limitation! Shared VPC's are also only available to Organizations.

## Subnets and Zones
Subnets are a regional resource, the instances running in the subnets are tied to a zone. To keep with the HA idea, I've gone ahead and spread my subnets accross both east1 and east4 regions.

## Instances
n2 can only exist in certain regions
n2's are also in high demand and I can't have any

## Manual Steps
Setup GCP with: 
- Projects (appliction and management)
- Service Accounts (for Terraform)
- Save service account credentials as `key.json` in the respected projects terraform

## Gotchas
Swapping my backend to ACL to allow another project to access the bucket broke terraform. Turns out I just needed to purge my .terraform and try again. -1 hour