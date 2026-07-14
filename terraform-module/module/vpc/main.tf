# vpc
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

# public subnet

resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.public_subnet
    availability_zone = "us-east-1a"
    map_public_ip_on_launch  = true

    tags = {
    Name = "${var.env_prefix}-public-sub"
  }
}


# private subnet

resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = var.private_subnet
    availability_zone = "us-east-1b" 

    tags = {
    Name = "${var.env_prefix}-privete-sub"
  }
}



#vpc internet gateway

resource "aws_internet_gateway" "mying" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
    Name = "${var.env_prefix}-ing"
  }
}

# creating route table and internet gateway connect to route tebles

resource "aws_route_table" "myRT" {
    vpc_id = aws_vpc.myvpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.mying.id
    }

    tags = {
      Name = "${var.env_prefix}-RT"
      }
}

# route table association with a subnet

resource "aws_route_table_association" "rtsub" {
    subnet_id = aws_subnet.public_sub.id
    route_table_id = aws_route_table.myRT.id

}
