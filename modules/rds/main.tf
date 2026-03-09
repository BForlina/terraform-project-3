resource "aws_db_subnet_group" "db_subnet_group" {

  subnet_ids = var.private_subnets

  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_security_group" "rds_sg" {

  vpc_id = var.vpc_id

  ingress {

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = ["10.0.0.0/16"]
  }
}

resource "aws_db_instance" "mysql" {

  engine = "mysql"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name = "appdb"

  username = var.db_username
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  skip_final_snapshot = true
}