# isv-workshop

將 AWS 驗證相關參數設定為環境變數
```
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```

使用 terraform 建立學員使用 VM
```bash
terraform init
terraform apply
```

取得 public_dns
```bash
terraform show -json|jq '.values.root_module.resources[] | select(.type == "aws_instance") | .values.public_dns'
```

使用 ssh 連線至 ec2
```bash
ssh ec2-user@[dns_name]
```
