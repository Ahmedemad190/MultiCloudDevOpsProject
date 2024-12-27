# MultiCloudDevOpsProject
This project involves a set how a set of tools can unit togther and come out with a real world project 
such as docker for the contranized app and terrafrom for resource provision and ansible for configurtion mangemnt and sonarqube for code analysis and jenkins for CI/CD work 
and openshift for deploy the appliction 
- First let's begin with terrafrom work
install terrafrom with the following
```
wget https://releases.hashicorp.com/terraform/<version>/terraform_1.6.0_linux_amd64.zip
```
- then unzip the binary 
```
wget https://releases.hashicorp.com/terraform/<version>/terraform_<version>_linux_amd64.zip
```
- then move it to the required PATH
```
sudo mv terraform /usr/local/bin/
```
create a user have the required access to create resources to avoid any errors during ur work create a user with administrator access 

then install awsCLI 

after this 
execute this 
```
aws configure
```
to enter ur creds also verify ur creds with 
```
aws sts get-caller-identity
```
you should see ur username and ur arn , etc..
you can check terrafrom modules from here 
## Why using Iac concept ? 
- becouse Manual configuration of infrastructure is error-prone and time-consuming. Terraform automates these processes and you can reuse the same code to build the infra or to modify it in few seconds with lines of code ⏰ 
- it let you to keep track of ur infra changes
- reduce human errors  💢
- Terraform allows you to track and optimize resources and quickly destroy unused environments, reducing waste.

:tada:[terrafrom modules](https://github.com/Ahmedemad190/MultiCloudDevOpsProject/tree/main/Terraform) 

- verfiy ur work go to aws console and search for the infrastucure you have provisioned
we need to create a vpc with public subnet and enable map_public_ip so every instance will attach to it a public ip without mentioned it to the resource you provisone
and create a EC2 instance which we will install the required packages for the project later on and create cloudwatch metric to send a mail if the therold exceeded SNS service will do it for you and the important thing is to store the .tfstate in the cloud in a s3 bucket :closed_lock_with_key:
### Why using ansible 
then ansible for confgution mangement i have choosed ansible becouse its an 
- agentless tool and simple to install it simply do what you will do in the terminal
- secure becouse it depend on SSH connection :key: 
- cloud provisioning, ad-hoc task execution, network automation, and multi-node orchestration :computer: 
so Ansible will install the required packages for us 📦
Let's begin with how to isntall ansible 

- update ur system 
```
sudo apt update && sudo apt upgrade -y
```
- Ansible is available in the official PPA (Personal Package Archive) maintained by the Ansible team.

```
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
```

- Last step tp install ansible
```
sudo apt install -y ansible
```
- verify ur install with
```
ansible -version
```
- create ansible role to install the required packages

What is ansilbe roles ?
Ansible roles are a way to organize and reuse automation tasks. They allow you to split your playbooks into smaller, reusable, and modular components. Each role contains tasks, variables, templates, handlers, and other elements needed to perform a specific automation task.
