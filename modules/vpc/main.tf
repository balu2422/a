resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.public_subnet_1_az
  tags = {
    Name = "${var.vpc_name}-public-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_2_cidr
  availability_zone = var.public_subnet_2_az
  tags = {
    Name = "${var.vpc_name}-public-2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_3_cidr
  availability_zone = var.public_subnet_3_az
  tags = {
    Name = "${var.vpc_name}-public-3"
  }
}
