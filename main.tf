module "vpc_network" {
  source = "./modules/vpc"
}

module "firewall_rules" {
  source = "./modules/fw_rules"
  vpc_network_name = module.vpc_network.name
}

module "public_subnets" {
  source = "./modules/ha_subnets"
  base_cidr = local.base_cidr
  index = 0
  public = true
  vpc_network_id = module.vpc_network.id
}

module "private_subnets" {
  source = "./modules/ha_subnets"
  base_cidr = local.base_cidr
  index = 2
  public = false
  vpc_network_id = module.vpc_network.id
}

module "dev_instance" {
  source = "./modules/instance"
  subnet = module.public_subnets.self_link_east1
  zone = "us-east1-d" # Todo: Tie region to subnet
  name = "dev"
  tags = module.firewall_rules.allow_ssh
}

module "apache_instance" {
  source = "./modules/instance"
  subnet = module.private_subnets.self_link_east1
  zone = "us-east1-d" # Todo: Tie region to subnet
  name = "apache"
  script = file("scripts/startup-apache.sh")
}

module "apache_lb" {
  source = "./modules/lb"
  name = "apache"
  instances = [module.apache_instance.id]
  zone = "us-east1-d" # Todo: Tie region to subnet
}