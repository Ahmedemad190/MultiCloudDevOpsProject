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

this is the strcutre 
```
├── ansible.cfg
├── docker
│   ├── defaults
│   │   └── main.yml
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── git
│   ├── defaults
│   │   └── main.yml
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── grad_proj.pem
├── inventory
├── jenkins
│   ├── defaults
│   │   └── main.yml
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── openshift
│   ├── defaults
│   │   └── main.yml
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── meta
│   │   └── main.yml
│   ├── README.md
│   ├── tasks
│   │   └── main.yml
│   ├── templates
│   ├── tests
│   │   ├── inventory
│   │   └── test.yml
│   └── vars
│       └── main.yml
├── playbook.yml
└── sonarqube
    ├── defaults
    │   └── main.yml
    ├── files
    ├── handlers
    │   └── main.yml
    ├── meta
    │   └── main.yml
    ├── README.md
    ├── tasks
    │   └── main.yml
    ├── templates
    ├── tests
    │   ├── inventory
    │   └── test.yml
    └── vars
        └── main.yml
```
we will create a role for docker and jenkisn and git and openshift and sonarqube 

to create a role 
```
ansible-galaxy init <role_name>
```
The folder strcurte will be as following 🚧 
```

roles/
  └── docker/
      ├── tasks/
      │   └── main.yml
      ├── vars/
      │   └── main.yml
      └── defaults/
          └── main.yml
```

You can find the roles here [Roles](https://github.com/Ahmedemad190/MultiCloudDevOpsProject/tree/main/Ansible) 
create the inventory file in which the playbook will execute in 
it should look like this 
```
[webserver]
[machine_IP]  ansible_user=ubuntu ansible_ssh_private_key_file=<path/to/private/key>
```
create the ansible.cfg 
it should look like that 
```
[defaults]
timeout = 30
remote_user = ubuntu
private_key_file = 
host_key_checking = False

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false
```
execute the playbook with 🪄
```
ansible-playbook -i inventory playbook.yml

```
check if the package installed with 
```
<package_name> --version
```
such as 
```
docker --version
```
do the same for all packages 
> [!IMPORTANT]
> the all files should be in the same directory 📁


then let's begin with jenkins work 
enter the secert key for jenkins 
![last](https://github.com/user-attachments/assets/6f7c5f59-3307-46b6-aa30-da0ce9140ed1) 

- First install the required plugins
Mange jenkins --> Plugins ---> avalible plugins

![image](https://github.com/user-attachments/assets/0f748eab-f5d8-44ec-a4f9-1b4bdbbe8c91)

- pipeline
- docker
- credentials
- sonarqube scanner
- aws credentials 

add the credentials 
for docker 
mange jenkins --> credentials ---> add cred --> kind username and password  
in the username enter ur username 
and in the password create a docker token from docker console 
and generate token for github the same as docker 
click on ur profile pic from the github console --->settings ---> Devolper options --> personal access token ---> Tokens (classic) 
create openshift token create with admin privilage 
💢 kind should be secert text 
```
     oc login cluset-url --username= --password=
     oc get all
     
     oc create serviceaccount jenkins2
     oc policy add-role-to-user admin system:serviceaccount:ahmedemad:jenkins2
     oc sa get-token jenkins2
```

![image](https://github.com/user-attachments/assets/7531f3ff-aff4-416a-bbc1-60ea552a5692)

create a cred for sonarqube 
click on ur logo ---> Myaccount --> security 
![image](https://github.com/user-attachments/assets/9da9f62e-f8e5-40e4-adb9-00b49ea53eb3)
copy the token 
go to 
mange jenkins --> cred ---> add cred ---> secert text ---> paste the token 

- create the jenkins shared library
go to mange jenkins ----> system ---> add the repo link and the name to call it into the pipeline
Deafult version mean the branch the .groovy files stored in 
![image](https://github.com/user-attachments/assets/67289e17-d70a-42e0-a505-389c33be20b9)

and add the sonarqube server ip as follwoing this stored in the same page 
![image](https://github.com/user-attachments/assets/9912e6e5-b5fe-4583-a394-b401eb698fe8)

### Why using shared library 
- create script you can call it in different pipelines
- Don't repeate ur code
- reuse and modify it to suite ur needs

you can find it here  [shared-lib](https://github.com/Ahmedemad190/shared-lib) 📝 
the next step is to create a new agent for jenkins 
in the agent machine install java version 17 
```
sudo apt install -y openjdk-17-jdk
```
in jenkins console 
mange jenkins --->nodes---->new node 
![image](https://github.com/user-attachments/assets/e96a32ff-070f-4620-a605-edaf99bc3992)

then enter the agent's data 
![image](https://github.com/user-attachments/assets/12e761f9-ad74-4c8b-8710-559928ef4195)
name and the host ip address "Remote root directory" it means the place where the agent will place it's folder label "the name you call it with in the pipeline" 
in the credentals part enter it private key 🔐

![image](https://github.com/user-attachments/assets/4a3c7d26-4544-45df-bc1d-87a951aa5ce9)

then the SonarQube 
#### Why using SonarQube ?
- Early Detection of Issues
- Code Quality Monitoring :telescope: 
- Continuous Integration and Continuous Delivery (CI/CD) Integration

create a new project with ![image](https://github.com/user-attachments/assets/c7bcff21-5c8b-4b99-8026-13573fc15d54)

then 

![image](https://github.com/user-attachments/assets/311df212-7623-4293-9db1-2c91716236f4)

# 📑 Troubleeshot phase

if the sonarQube webpage didn't apper after executing the playbook then go to /opt/sonarQube/<sonar_version>/sonar.log it should look like that 
![image](https://github.com/user-attachments/assets/57ee5e6c-645e-45e2-b2ca-f77b68778b8d)

if not make sure that 
1. elsatic search is up and running not in the waiting state ▶️ check this in /opt/sonarQube/<sonar_version>/nohub.log

# The pipline step 

For this step  i used jenkins for creating effieciet CI/CD pipelineg
To integrate and automate the workflow, I configured a Jenkins pipeline with the following stages:

Checkout Stage: Cloning the repository.
Build and Push: Building and pushing a Docker image to a container registry.⚓
Unit Testing: Running unit tests to ensure code quality.:mag_right: 
SonarQube Analysis: Performing static code analysis.
Deployment to OpenShift: Deploying the application using deployment.yml and service.yml, with service exposure configured for accessibility.


