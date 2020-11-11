variable "region" {
  type          = "string"
}

variable "environment" {
  type          = "string"
}

variable "cluster" {
  type          = "string"
}

variable "service" {
  type          = "string"
}

variable "project" {
  type          = "string"
}

variable "owner" {
  type        = "string"
}

variable "owner_slack_channel" {
  type        = "string"
}

variable "vpc_cidr_block" {
  type          = "string"
}

variable "iam_permissions_boundary" {
  type    = "string"
}

variable "aws_host" {
  type          = "string"
  default       = "localhost"
}
