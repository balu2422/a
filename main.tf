module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_1_az = var.public_subnet_1_az
  public_subnet_2_cidr = var.public_subnet_2_cidr
  public_subnet_2_az = var.public_subnet_2_az
  public_subnet_3_cidr = var.public_subnet_3_cidr
  public_subnet_3_az = var.public_subnet_3_az
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
  sg_name = var.sg_name
}

module "ec2" {
  source = "./modules/ec2"
  ami_id = var.ami_id
  instance_type = var.instance_type
  subnet_id = module.vpc.public_subnet_1_id
  security_group_id = module.sg.alb_sg_id
  instance_name = var.instance_name
}

module "alb" {
  source = "./modules/alb"
  alb_name = var.alb_name
  security_group_id = module.sg.alb_sg_id
  subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id, module.vpc.public_subnet_3_id]
  vpc_id = module.vpc.vpc_id
  target_groups = var.target_groups
  target_group_attachments = var.target_group_attachments
  listener_rules = var.listener_rules
}
