#!/bin/bash
yum update -y
yum install -y unzip python git python-devel openssl curl
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py && pip install awscli
yum install -y ansible
wget https://releases.hashicorp.com/terraform/0.8.4/terraform_0.8.4_linux_amd64.zip
mkdir ~/terraform
unzip terraform_0.8.4_linux_amd64.zip -d ~/terraform
export PATH=$PATH:~/terraform