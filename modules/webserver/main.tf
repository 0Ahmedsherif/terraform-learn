# Ec2
data "aws_ami" "Latest-amazon-linux-image" {
    most_recent = true
    owners = ["137112412989"]
    
    filter {
        name   = "name"
        values = [var.image_name] 
    # values means it's name must start with "amzn2-ami-kernel" and ends with "x86_64-gp2" and ignore inbetween 
  }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }     
}

resource "aws_instance" "myapp-server" {
  ami           = data.aws_ami.Latest-amazon-linux-image.id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_default_security_group.default-sg.id]
  availability_zone = var.az
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name
  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.env_prefix}-server"
  }
}

# Key-pair
resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location)
}

# Security group
# using the default security group
resource "aws_default_security_group" "default-sg" {
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}