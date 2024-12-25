resource "aws_vpc" "ivolve-vpc-SNS" {
    cidr_block = var.vpc_cidr_block
   tags = {
     Name = "VPC_SNS"
   }
}