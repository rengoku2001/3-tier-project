#creating vpc with 8 subnets
resource "aws_vpc" "three-tier" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    tags = {
      Name="3-tier-vpc"
    }
}

resource "aws_subnet" "pub-1" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true #to assign public IP
    tags = {
      Name="pub-1a"
    }  
}

resource "aws_subnet" "pub-2" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true #to assign public IP
    tags = {
      Name="pub-2b"
    }
}

resource "aws_subnet" "pvt-3" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name="pvt-3a"
    }
}

resource "aws_subnet" "pvt-4" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name="pvt-4b"
    }
}

resource "aws_subnet" "pvt-5" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name="pvt-5a"
    }
}

resource "aws_subnet" "pvt-6" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.5.0/24"
    availability_zone = "ap-south-1b"
    tags = {
        Name="pvt-6b"
    }
  
}

resource "aws_subnet" "pvt-7" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.6.0/24"
    availability_zone = "ap-south-1a"
    tags = {
        Name="pvt-7a"  
    }
  
}

resource "aws_subnet" "pvt-8" {
    vpc_id = aws_vpc.three-tier.id
    cidr_block = "10.0.7.0/24"
    availability_zone = "ap-south-1b"
    tags = {
      Name="pvt-8b"
    }
}

#creating IG
resource "aws_internet_gateway" "3-tier-ig" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name="3-tier-ig"
    }
}

#creating public route table
resource "aws_route_table" "3-tier-pub-rt" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
        Name="3-tier-pub-rt"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.3-tier-ig.id
    }
}

#attaching 1a-sub to public rt
resource "aws_route_table_association" "pub-1a" {
    route_table_id = aws_route_table.3-tier-pub-rt.id 
    subnet_id = aws_subnet.pub-1.id
}

#attaching 1b-sub to public rt
resource "aws_route_table_association" "pub-2b" {
    route_table_id = aws_route_table.3-tier-pub-rt.id 
    subnet_id = aws_subnet.pub-2.id 
}

#creating elastic ip for nat gataeway
resource "aws_eip" "eip" {
}

#creating nat gateway
resource "aws_nat_gateway" "3-tier-nat" {
    subnet_id = aws_subnet.pub-1.id
    connectivity_type = "public"
    allocation_id = aws_eip.eip.id
    tags = {
        Name="3-tier-nat"
    }
}

#creating pvt route table 
resource "aws_route_table" "3-tier-pvt-rt" {
    vpc_id = aws_vpc.three-tier.id
    tags = {
      Name="3-tier-pvt-rt"
    }
    route {
        cidr_block = "0.0.0.0/0" 
        nat_gateway_id = aws_nat_gateway.3-tier-nat.id 
   }
}

#attaching pvt-3a sub to pvt rt
resource "aws_route_table_association" "pvt-3a" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id 
    subnet_id = aws_subnet.pvt-3.id  
}

#attaching pvt-4b sub to pvt rt
resource "aws_route_table_association" "pvt-4b" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id 
    subnet_id = aws_subnet.pvt-4.id
}

#attaching pvt-5a sub to pvt rt
resource "aws_route_table_association" "pvt-5a" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id
    subnet_id = aws_subnet.pvt-5.id
}

#attaching pvt-6b sub to pvt rt 
resource "aws_route_table_association" "pvt-6b" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id 
    subnet_id = aws_subnet.pvt-6.id  
}

#attaching pvt-7a sub to pvt rt 
resource "aws_route_table_association" "pvt-7a" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id 
    subnet_id = aws_subnet.pvt-7.id
}

#attaching pvt-8b sub to pvt rt
resource "aws_route_table_association" "pvt-8b" {
    route_table_id = aws_route_table.3-tier-pvt-rt.id 
    subnet_id = aws_subnet.pvt-8.id
  
}