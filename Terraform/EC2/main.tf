resource "aws_instance" "ivolve-ec2" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  
  key_name = "grad_proj"
    root_block_device {
    volume_size = 20
    volume_type = "gp2"
  }
  lifecycle {
  create_before_destroy = true
  }
  tags = {
    Name = "ivolve-ec2"
  }
}