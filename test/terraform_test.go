package test

import (
	"testing"
	"fmt"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/aws/aws-sdk-go/service/ec2"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/aws"
)

func TestTerraform(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
		TerraformDir: "..",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
      "vpc_id": "vpc-00d6b51d02b2d5160",
      "name": "securitygroup-test",
      "use_name_prefix": "false",
      "egress_cidr_blocks": []string{"0.0.0.0/0",},
      "egress_rules": []string{"all-all",},
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": "us-east-1",
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

    // AWS

    // Security Group
    security_group_name := terraform.Output(t, terraformOptions, "this_security_group_name")
    var security_group_names []string

    svc_ec2 := ec2.New(session.New(&aws.Config{
        Region: aws.String("us-east-1"),
    }))
    input_sg := &ec2.DescribeSecurityGroupsInput{}
    err_sg := svc_ec2.DescribeSecurityGroupsPages(input_sg,
        func(page *ec2.DescribeSecurityGroupsOutput, lastPage bool) bool {
            for _, v := range page.SecurityGroups {
                security_group_names = append(security_group_names, aws.StringValue(v.GroupName))
            }
            return lastPage
        },
    )
    if err_sg != nil {
        fmt.Println(err_sg.Error())
        return
    }

    assert.Contains(t, security_group_names, security_group_name)
}
