# About the project

build an environment with terraform on Azure.

# About the architecture

this terraform project will create 3 servers 
(planned to be web servers), behind Load Balancer, connected into isolated postgres server. 

<img src= images/week-4-project-env.png>

## Installation

```bash
git clone https://github.com/entebox/week5_Project.git
```
## Terraform Precedures before first use

https://learn.hashicorp.com/tutorials/terraform/install-cli

## Usage

```c#
# initialize a working directory containing Terraform configuration files 
terraform init

# to executes the actions proposed in a Terraform plan
terraform apply

```
## Branches and their purpose

### Branch Bonus A
created backend to store the Terraform state in Azure Blob Storage

### Branch Bonus B
Used the Azure PostgreSQL manged service instead of a VM

### Branch Bonus C
Implemented Elasticity using Terraform

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
