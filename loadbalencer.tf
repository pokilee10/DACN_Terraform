# Create Network Load Balancer for Service 1
resource "aws_lb" "service_1_nlb" {
  name               = "service-1-nlb"
  internal           = false
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id     = aws_subnet.public_subnet.id
    allocation_id = aws_eip.service_1_eip.id
  }

  tags = {
    Name = "Service 1 NLB"
  }
}

# Create Network Load Balancer for Service 2
resource "aws_lb" "service_2_nlb" {
  name               = "service-2-nlb"
  internal           = false
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id     = aws_subnet.public_subnet.id
    allocation_id = aws_eip.service_2_eip.id
  }

  tags = {
    Name = "Service 2 NLB"
  }
}

# Create Network Load Balancer for Service 3
resource "aws_lb" "service_3_nlb" {
  name               = "service-3-nlb"
  internal           = false
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id     = aws_subnet.public_subnet.id
    allocation_id = aws_eip.service_3_eip.id
  }

  tags = {
    Name = "Service 3 NLB"
  }
}