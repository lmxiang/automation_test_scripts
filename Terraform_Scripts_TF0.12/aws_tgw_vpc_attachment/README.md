## aviatrix_aws_tgw_vpc_attachment

---

### Usage
```
  terraform init
  terraform apply -var-file=/path/provider_cred.tfvars -auto-approve
  terraform plan -var-file=/path/provider_cred.tfvars -detailed-exitcode
  terraform show

  terraform state rm aviatrix_aws_tgw_vpc_attachment.tgw_vpc_attach_test
  terraform import -var-file=/path/provider_cred.tfvars aviatrix_aws_tgw_vpc_attachment.tgw_vpc_attach_test testAWSTGW2~SDN1~vpc-00119a5b202c81d97
  terraform plan -var-file=/path/provider_cred.tfvars -detailed-exitcode
  terraform show

  terraform apply -var-file=/path/provider_cred.tfvars \
                  -var-file=updateSecurityDomain.tfvars \
                  -auto-approve
  terraform show
  terraform apply -var-file=/path/provider_cred.tfvars \
                  -var-file=updateCustomRoutes.tfvars \
                  -auto-approve
  terraform show
  terraform apply -var-file=/path/provider_cred.tfvars \
                  -var-file=disableLocalRouteProp.tfvars \
                  -auto-approve
  terraform show

  terraform destroy -var-file=/path/provider_cred.tfvars -auto-approve
```
