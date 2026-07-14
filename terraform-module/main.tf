

module "vpc" {
    source = "./module/vpc"
    vpc_cidr_block    =  var.vpc_cidr_block
    public_subnet     =  var.public_subnet  
    availbility_zone  =  var.availbility_zone 
    private_subnet    =  var.private_subnet 
    env_prefix        =  var.env_prefix
  
}

# my security group

module "security" {
    source = "./module/security"
    vpc_id = module.vpc.vpc.id
    env_prefix     =  var.env_prefix
  
}

# creating aws ec2 instance

resource "aws_instance" "myec2" {
    ami               = var.ami
    instance_type     = "t2.micro"
    subnet_id         = module.vpc.subnet.id
    vpc_security_group_ids =  [module.security.security.id]
    associate_public_ip_address = true
    user_data = file("userdata.tpl")
    key_name    = var.key_name

    tags = {
    Name = "${var.env_prefix}-ec2"
  }
    
}