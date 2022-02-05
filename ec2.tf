data "aws_ami" "Latest-amazon-linux-image" {
    most_recent = true
    owners = ["137112412989"]
    
    filter {
        name   = "name"
        values = ["amzn2-ami-kernel-*-x86_64-gp2"] 
    # values means it's name must start with "amzn2-ami-kernel" and ends with "x86_64-gp2" and ignore inbetween 
  }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }   
}

output "aws_ami_id" {
  value       = data.aws_ami.Latest-amazon-linux-image.id
}

resource "aws_instance" "myapp-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.az
  associate_public_ip_address = true
}