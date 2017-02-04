apt-get -y update
apt-get -y install curl unzip wget
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install awscli

mkdir ~/terraform
wget https://releases.hashicorp.com/terraform/0.8.5/terraform_0.8.5_linux_amd64.zip
unzip terraform_0.8.5_linux_amd64.zip -d ~/terraform
# export PATH=$PATH:~/terraform

# install ansible
apt-add-repository ppa:ansible/ansible
apt-get -y update
apt-get -y install ansible

# adjust ntp to avoid AWS Signature issues with time
apt-get -y install ntp
service ntp stop
ntpdate -s us.pool.ntp.org
service ntp start

# aws route53 create-reusable-delegation-set --caller-reference 12345

vagrantTip="[35m[1mThe shared directory is located at /vagrant\nTo access your shared files: cd /vagrant(B[m"
echo -e $vagrantTip > /etc/motd
