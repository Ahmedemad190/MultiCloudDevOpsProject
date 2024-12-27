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
use
```
aws configure
```
to enter ur creds also verify ur creds with 
```
aws sts get-caller-identity
```
you can check terrafrom modules from here 
[terrafrom modules](https://github.com/Ahmedemad190/MultiCloudDevOpsProject/tree/main/Terraform)
