resource "aws_instance" "front" {
    ami = var.ami
    key_name = var.key-name
    instance_type = var.instance-type
    # subnet_id = aws_subnet.pub1.id
    # vpc_security_group_ids = [aws_security_group.frontend-server-sg.id ]
    user_data = templatefile("./frontend.sh",{})
    tags = {
      Name="frontend-server"
    }
     
  
}