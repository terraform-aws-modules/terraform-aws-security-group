package test

import (
	"testing"
	"fmt"
	"os"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraform(t *testing.T) {
		// get localstack host
		aws_host := os.Getenv("AWS_HOST")
		if aws_host == "" {
			aws_host = "localhost"
		}
		fmt.Println("Expecting localstack on", aws_host)

		// configure the test
		terraformOptions := &terraform.Options{
			// set the path to the terraform code that will be tested
			TerraformDir: "./sg",
			// set variables; set localstack host var
			Vars:  map[string]interface{} {
				"aws_host": aws_host,
			},

			// Environment variables to set when running Terraform
			EnvVars: map[string]string{
				"AWS_DEFAULT_REGION": "us-east-1",
			},
		}

		// configure to clean up resources with `terraform destroy` at the end of the test
		defer terraform.Destroy(t, terraformOptions)

		// BUILD VERIFICATION TEST (attempt to run `terraform init` and `terraform apply`)
		terraform.InitAndApply(t, terraformOptions)

		// UNIT TESTS
		// run `terraform output` and verify values
		this_security_group_id := terraform.Output(t, terraformOptions, "this_security_group_id")
		fmt.Println(this_security_group_id)
		assert.NotNil(t, this_security_group_id)
		this_security_group_vpc_id := terraform.Output(t, terraformOptions, "this_security_group_vpc_id")
		fmt.Println(this_security_group_vpc_id)
		assert.NotNil(t, this_security_group_vpc_id)
		this_security_group_owner_id := terraform.Output(t, terraformOptions, "this_security_group_owner_id")
		fmt.Println(this_security_group_owner_id)
		assert.NotNil(t, this_security_group_owner_id)
		this_security_group_name := terraform.Output(t, terraformOptions, "this_security_group_name")
		fmt.Println(this_security_group_name)
		assert.Equal(t, "securitygroup-test", this_security_group_name)
		this_security_group_description := terraform.Output(t, terraformOptions, "this_security_group_description")
		fmt.Println(this_security_group_description)
		assert.Equal(t, "Security Group managed by Terraform", this_security_group_description)
}
