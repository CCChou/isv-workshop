# isv-workshop

將 AWS 驗證相關參數設定為環境變數
```
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
```

複製範例參數檔
```bash
cp bastion.tfvars.example bastion.tfvars
```

根據需求修改參數
```bash
vim bastion.tfvars
```
```conf
# EC2 使用的 AMI
ami = ""
# EC2 使用的 instance type
instance_type = ""
# EC2 連線用的 public key
ssh_public_key = ""
```

初始化 terraform 環境
```bash
terraform init
```

使用 terraform 建立學員使用 VM
```bash
terraform apply -var-file="bastion.tfvars" --auto-approve
```

取得 public_dns
```bash
export FQDN=$(terraform show -json|jq '.values.root_module.resources[] | select(.type == "aws_instance") | .values.public_dns')
export FQDN=${FQDN//\"}
```

使用 ssh 連線至 ec2
```bash
ssh ec2-user@$FQDN
```
