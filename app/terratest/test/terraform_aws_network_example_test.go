package test

import (
	// "fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// An example of how to test the Terraform module in examples/terraform-aws-network-example using Terratest.
func TestTerraformAwsNetworkExample(t *testing.T) {
	t.Parallel()

	awsRegion := "us-east-2"
	// Construct the terraform options with default retryable errors to handle the most common retryable errors in
	// terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../..",

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region":                       awsRegion,
			"project_name":                 "webapp-ecs",
			"vpc_cidr":                     "10.0.0.0/16",
			"public_subnet_cidr_az1":       "10.0.0.0/24",
			"public_subnet_cidr_az2":       "10.0.1.0/24",
			"private_app_subnet_az1_cidr":  "10.0.2.0/24",
			"private_app_subnet_az2_cidr":  "10.0.3.0/24",
			"private_data_subnet_az1_cidr": "10.0.4.0/24",
			"private_data_subnet_az2_cidr": "10.0.5.0/24",
			"public_subnet_name":           "public-subnet",
		},
	})

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	publicSubnetId := terraform.Output(t, terraformOptions, "public_subnet_id")
	privateSubnetId := terraform.Output(t, terraformOptions, "private_subnet_id")
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")

	subnets := aws.GetSubnetsForVpc(t, vpcId, awsRegion)
	require.Equal(t, 6, len(subnets))
	// Verify if the network that is supposed to be public is really public
	assert.True(t, aws.IsPublicSubnet(t, publicSubnetId, awsRegion))
	// Verify if the network that is supposed to be private is really private
	assert.False(t, aws.IsPublicSubnet(t, privateSubnetId, awsRegion))
}
