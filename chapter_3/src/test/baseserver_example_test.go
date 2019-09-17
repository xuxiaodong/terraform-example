package test

import (
	"crypto/tls"
	"fmt"
	"testing"
	"time"
	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestBaseserverExample(t *testing.T)  {
	// 配置 Terraform
	opts := &terraform.Options{
		TerraformDir: "../",
	}

	// 测试完成后，执行 `terraform destroy` 清理资源
	defer terraform.Destroy(t, opts)

	// 初始化并运行 Terraform 代码
	terraform.InitAndApply(t, opts)

	// 执行 `terraform output` 以获取输出变量的值
	serverIp := terraform.OutputRequired(t, opts, "ip")
	url := fmt.Sprintf("http://%s", serverIp)

	// 设置 TLS，http_helper 需要
	tlsConfig := tls.Config{}

	// 期望得到的 HTTP 状态及消息
	expectedStatus := 200
	expectedBody := "Created: Hello, 2019"

	// 设置重试次数
	maxRetries := 30
	timeBetweenRetries := 10 * time.Second

	// 验证 HTTP
	http_helper.HttpGetWithRetry(
		t,
		url,
		&tlsConfig,
		expectedStatus,
		expectedBody,
		maxRetries,
		timeBetweenRetries,
	)
}