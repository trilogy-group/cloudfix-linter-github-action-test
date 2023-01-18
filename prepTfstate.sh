#!/bin/bash
terraform_init=$(terraform init)
status=$?
if [ $status != 0 ] 
then
    echo "Terraform Init\n${terraform_init}"
    exit 1
fi
echo "Terraform Init\n"

terraform_validate=$(terraform validate -no-color)
status=$?
if [ $status != 0 ] 
then
    echo "Terraform Validate\n${terraform_validate}"
    exit 1
fi
echo "Terraform Validate\n"


terraform_show=$(terraform show -json | head -2 | tail -1 > tf.show)
status=$?
if [ $status != 0 ] 
then
    echo "Terraform Show\n${terraform_show}"
    exit 1
fi
echo "Terraform Show\n"
