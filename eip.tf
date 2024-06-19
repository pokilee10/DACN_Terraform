# Create Elastic IPs
resource "aws_eip" "service_1_eip" {
  vpc = true
}

resource "aws_eip" "service_2_eip" {
  vpc = true
}

resource "aws_eip" "service_3_eip" {
  vpc = true
}