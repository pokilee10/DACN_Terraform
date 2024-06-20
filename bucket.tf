terraform {
  backend "s3" {
    bucket = "ec2mytfstate6"  # Tên của bucket S3 bạn đã tạo
    key    = "state/terraform.tfstate"  # Đường dẫn đến file trạng thái
    region = "us-east-1"  # Vùng AWS mà bucket S3 của bạn nằm trong đó
  }
}