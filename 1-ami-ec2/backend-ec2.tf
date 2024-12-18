resource "aws_instance" "front" {
    ami = var.ami
    key_name = var.key-name
    instance_type = var.instance-type
    # subnet_id = aws_subnet.pub2.id
    # vpc_security_group_ids = [aws_security_group.backend-server-sg.id ]
    user_data = templatefile("./backend.sh",{})
    tags = {
      Name="backend-server"
    }
     
  
}