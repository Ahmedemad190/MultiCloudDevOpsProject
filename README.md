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

:tada:[terrafrom modules](https://github.com/Ahmedemad190/MultiCloudDevOpsProject/tree/main/Terraform) 
- verfiy ur work go to aws console and search for the infrastucure you have provisioned
we need to create a vpc with public subnet and enable map_public_ip so every instance will attach to it a public ip without mentioned it to the resource you provisone
and create a EC2 instance which we will install the required packages for the project later on and create cloudwatch metric to send a mail if the therold exceeded SNS service will do it for you and the important thing is to store the .tfstate in the cloud in a s3 bucket :closed_lock_with_key:
## Why using ansible 
then ansible for confgution mangement i have choosed ansible becouse its an 
- agentless tool and simple to install it simply do what you will do in the terminal
- secure becouse it depend on SSH connection
-  cloud provisioning, ad-hoc task execution, network automation, and multi-node orchestration :computer: 

