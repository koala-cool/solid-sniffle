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