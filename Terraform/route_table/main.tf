resource "aws_route_table" "ivolve-RT" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = var.internet_gateway_id
    }
    tags = {
      Name = "ivolve-RT"
    }
}

resource "aws_route_table_association" "ivolve-rta" {
    subnet_id      = var.subnet_id 
    route_table_id = aws_route_table.ivolve-RT.id
}
