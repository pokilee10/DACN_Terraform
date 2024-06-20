terraform {
  backend "s3" {
    bucket = "ecss3bucket"  # Tên của bucket S3 bạn đã tạo
    key    = "state/terraform.tfstate"  # Đường dẫn đến file trạng thái
    region = "us-east-2"  # Vùng AWS mà bucket S3 của bạn nằm trong đó
  }
}