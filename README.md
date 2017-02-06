## Deploying to AWS with Ansible and Terraform
- A  multi-tier WordPress application on AWS using both Terraform and Ansible. 
-  Ansible is used in order to configure the instances to run a WordPress application. At the end a functional WordPress application is deployed
-  A Vagrantfile is included that can be used to launch an Ubuntu evnvironment with the required packages and software installed for deploying the WordPress application to AWS
-  The Vagrantfile comes with the following installed:
   - [Terraform](https://www.terraform.io/)
   - [AWS CLI](https://aws.amazon.com/cli)

### Prerequisites
- [Amazon Web Services](https://aws.amazon.com) Account is needed
- Download and install [Vagrant](https://www.vagrantup.com/downloads.html)
- Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

#### How to Run the Project
- Clone this project and navigate into the **Ansiform** folder
- run the command vagrant up and then vagrant ssh to access the Ubuntu environment
- change directory into the **/vagrant** folder
- create an **SSH Key** and add it to your ssh-agent
- run command **export PATH=$PATH:~/terraform**
- run terraform plan and supply necessary variables
- run terraform apply to deploy the infrasture and Wordpress to AWS
- use the IP address in the aws_hosts file to navigate to the admin portal of the Wordpress site (make required changes to your need and save)
- run **ansible-playbook -i aws_hosts s3update.yml** to deploy the new changes after 5 mins
- run **terraform destroy** to destroy the infrastructure. 



