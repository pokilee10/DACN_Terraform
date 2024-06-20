provider "aws" {
  region     = "us-east-2"
}

# Tạo VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My VPC"
  }
}

# Tạo subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Public Subnet"
  }
}

# Tạo Internet Gateway và Route Table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "My Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Tạo security group
resource "aws_security_group" "my_security_group" {
  name_prefix = "my-sg-"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0 
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My Security Group"
  }
}

# Tạo ECS cluster
resource "aws_ecs_cluster" "my_cluster" {
  name = "my-ecs-cluster"

  tags = {
    Name = "My ECS Cluster"
  }
}

# Tạo vai trò thực thi tác vụ ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRolenew"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "ECSTaskExecutionRole"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Tạo nhóm nhật ký CloudWatch
resource "aws_cloudwatch_log_group" "my_log_group" {
  name              = "/ecs/my-container"
  retention_in_days = 7

  tags = {
    Name = "My ECS Log Group"
  }
}

# Tạo định nghĩa tác vụ ECS cho container 1
resource "aws_ecs_task_definition" "task_1" {
  family                   = "task-1"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 4096

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "container-frontend",
    "image": "pokilee10/frontend:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "DOCKER_USER",
        "value": "pokilee10"
      },
      {
        "name": "DOCKER_PASSWORD",
        "value": "Linh2003."
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.my_log_group.name}",
        "awslogs-region": "us-east-2",
        "awslogs-stream-prefix": "container-1"
      }
    }
  }
]
DEFINITION
}

# Tạo định nghĩa tác vụ ECS cho container 2
resource "aws_ecs_task_definition" "task_2" {
  family                   = "task-2"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 4096

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "container-backend",
    "image": "pokilee10/backend:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 4000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "DOCKER_USER",
        "value": "pokilee10"
      },
      {
        "name": "DOCKER_PASSWORD",
        "value": "Linh2003."
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.my_log_group.name}",
        "awslogs-region": "us-east-2",
        "awslogs-stream-prefix": "container-2"
      }
    }
  }
]
DEFINITION
}

# Tạo định nghĩa tác vụ ECS cho container 3
resource "aws_ecs_task_definition" "task_3" {
  family                   = "task-3"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 4096

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = <<DEFINITION
[
  {
    "name": "container-admin",
    "image": "pokilee10/admin:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "DOCKER_USER",
        "value": "pokilee10"
      },
      {
        "name": "DOCKER_PASSWORD",
        "value": "Linh2003."
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${aws_cloudwatch_log_group.my_log_group.name}",
        "awslogs-region": "us-east-2",
        "awslogs-stream-prefix": "container-3"
      }
    }
  }
]
DEFINITION
}

# Update ECS service 1
resource "aws_ecs_service" "service_1" {
  name            = "service-frontend"
  cluster         = aws_ecs_cluster.my_cluster.id
  desired_count   = 1
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_1.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.service_1_tg.arn
    container_name   = "container-frontend"
    container_port   = 3000
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }

  tags = {
    Name = "Service 1"
  }
}

# Update ECS service 2
resource "aws_ecs_service" "service_2" {
  name            = "service-backend"
  cluster         = aws_ecs_cluster.my_cluster.id
  desired_count   = 1
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_2.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.service_2_tg.arn
    container_name   = "container-backend"
    container_port   = 4000
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }

  tags = {
    Name = "Service 2"
  }
}

# Update ECS service 3
resource "aws_ecs_service" "service_3" {
  name            = "service-admin"
  cluster         = aws_ecs_cluster.my_cluster.id
  desired_count   = 1
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.task_3.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.service_3_tg.arn
    container_name   = "container-admin"
    container_port   = 8080
  }

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 50

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }

  tags = {
    Name = "Service 3"
  }
}
