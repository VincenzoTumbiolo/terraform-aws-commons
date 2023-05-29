resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.0.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}a"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/public_subnet1" })
}
resource "aws_route_table" "public_rtb1" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/${var.vpc_sub_mask_dimension}"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/public_rtb1" })
}
resource "aws_route_table_association" "public_association1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rtb1.id
}

resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.32.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}b"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/public_subnet2" })
}
resource "aws_route_table" "public_rtb2" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/${var.vpc_sub_mask_dimension}"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/public_rtb2" })
}
resource "aws_route_table_association" "public_association2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rtb2.id
}



resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.64.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}a"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/private_subnet1" })
}
resource "aws_route_table" "private_rtb1" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/${var.vpc_sub_mask_dimension}"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/private_rtb1" })
}
resource "aws_route_table_association" "private_association1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rtb1.id
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.96.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}b"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/private_subnet2" })
}
resource "aws_route_table" "private_rtb2" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/${var.vpc_sub_mask_dimension}"
    gateway_id = aws_nat_gateway.this.id
  }

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/private_rtb2" })
}
resource "aws_route_table_association" "private_association2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rtb2.id
}



resource "aws_subnet" "isolated_subnet1" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.128.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}a"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/isolated_subnet1" })
}
resource "aws_route_table" "isolated_rtb1" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/isolated_rtb1" })
}
resource "aws_route_table_association" "isolated_association1" {
  subnet_id      = aws_subnet.isolated_subnet1.id
  route_table_id = aws_route_table.isolated_rtb1.id
}

resource "aws_subnet" "isolated_subnet2" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.160.0/${var.subnet_sub_mask_dimension}"
  availability_zone = "${var.region}b"

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/isolated_subnet2" })
}
resource "aws_route_table" "isolated_rtb2" {
  vpc_id = aws_vpc.this.id

  tags = merge(local.tags, { Name = "${var.env}/${local.tags.project_prefix}/isolated_rtb2" })
}
resource "aws_route_table_association" "isolated_association2" {
  subnet_id      = aws_subnet.isolated_subnet2.id
  route_table_id = aws_route_table.isolated_rtb2.id
}










