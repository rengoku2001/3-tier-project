variable "ami" {
    description = "ami"
    type = string
    default = "ami-053b12d3152c0cc71"
}

variable "instance-type" {
    description = "instance-type"
    type = string
    default = "t2.micro"
}

variable "key-name" {
    description = "key-name"
    type = string
    default = "mumbai" 
}