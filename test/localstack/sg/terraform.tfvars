region = "us-east-1"

environment              = "sandbox"
cluster                  = "sre"
service                  = "eks"
project                  = "srecore"

owner                    = "some_owner"
owner_slack_channel      = "some-channel"

vpc_cidr_block           = "172.24.0.0/16"
iam_permissions_boundary = "arn:aws:iam::373673428400:policy/Sandbox-Boundary-IAM-BaselinePolicy"
