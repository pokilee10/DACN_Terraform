resource "aws_route53_zone" "easy_aws" {
  name = "tuilalinh.id.vn"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "fe" {
  zone_id = aws_route53_zone.easy_aws.zone_id
  name    = "tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = aws_lb.service_1_nlb.dns_name
    zone_id                = aws_lb.service_1_nlb.zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "be" {
  zone_id = aws_route53_zone.easy_aws.zone_id
  name    = "api.tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = aws_lb.service_2_nlb.dns_name
    zone_id                = aws_lb.service_2_nlb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "admin" {
  zone_id = aws_route53_zone.easy_aws.zone_id
  name    = "admin.tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = aws_lb.service_3_nlb.dns_name
    zone_id                = aws_lb.service_3_nlb.zone_id
    evaluate_target_health = true
  }
}


output "name_server"{
  value=aws_route53_zone.easy_aws.name_servers
}