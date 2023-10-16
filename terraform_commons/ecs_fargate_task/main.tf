resource "aws_iam_role" "ecs_task_role" {
  name = "${var.ecs_name}-ecsTaskRole"
  tags = var.tags

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

data "aws_iam_policy_document" "ecs_policy" {
  statement {
    sid = "0"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:*"
    ]
  }
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  name   = "${var.ecs_name}-log-policy"
  role   = aws_iam_role.ecs_task_role.name
  policy = data.aws_iam_policy_document.ecs_policy.json
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.ecs_name}-ecsTaskExecutionRole"
  tags = var.tags

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "task_s3" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

locals {
  log_group_name = "/aws/ecs/${var.ecs_name}"
}

resource "aws_cloudwatch_log_group" "service" {
  name = local.log_group_name

  tags = var.tags
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.ecs_name}-task" # Naming our first task
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode(
    flatten([{
      name        = "${var.ecs_name}-container"
      image       = var.ecr_repository_url
      essential   = true
      environment = var.environments
      portMappings = [{
        protocol      = "tcp"
        containerPort = var.task_containerPort
        hostPort      = var.task_hostPort
      }],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "${tostring(local.log_group_name)}",
          awslogs-region        = "${tostring(var.region)}",
          awslogs-stream-prefix = "ecs"
        }
      }
      }, var.ddog_enable ? [{
        name        = "${var.ecs_name}-ddog-container",
        image       = var.ddog_image,
        environment = var.ddog_environments
  }] : []]))

  tags = var.tags
}
