module "vpc" {
    source = "./VPC"

  
}
module "subnet" {
    source = "./subnet"
    vpc_id = module.vpc.vpc_id
  
}
module "internet_gateway" {
  source = "./internet-gateway"
  vpc_id = module.vpc.vpc_id
}
module "route_table" {
    source = "./route_table"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.subnet.subnet_id
    internet_gateway_id = module.internet_gateway.internet_gateway_id
  
}
module "sec_gp" { 
    source = "./security_group"
    vpc_id = module.vpc.vpc_id
}
module "ec2" {
    source = "./ec2"
    subnet_id = module.subnet.subnet_id 
    security_group_id = module.sec_gp.security_group_id
  
}
module "SNS" { 
    source = "./SNS"
    email_endpoint = "aemad4808@gmail.com"
}
module "cloudwatch" {
    source = "./cloudwatch"
    instance_id = module.ec2.instance_id
    alarm_sns_topic_arn = module.SNS.sns_topic_arn
    cpu_threshold = 60
    memory_threshold = 60
    disk_threshold = 60
}