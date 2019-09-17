package test

import (
	"fmt"
	"time"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestBaseserverExample(t *testing.T)  {
	opts := &terraform.Options{
		TerraformDir: "../",
	}

	terraform.InitAndApply(t, opts)

	serverIp := terraform.OutputRequired(t, opts, "ip")
	url := fmt.Sprintf("http://%s", serverIp)

	expectedStatus := 200
	expectedBody := "Hello, 2019"

	maxRetries := 10
	timeBetweenRetries := 10 * time.Second

	http_helper.HttpGetWithRetry(
		t,
		url,
		expectedStatus,
		expectedBody,
		maxRetries,
		timeBetweenRetries,
	)
}