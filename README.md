# Deploying NodeJS server using Terraform 

This document explains how to deploy a Node server using terraform on AWS cloud.

## Building the application Image
Using the docker file, you can create an image for your the application and push to your preferred Container registry. 

```sh
docker build -t <image tag> .
```

## Deploying the application 
To deploy the application, appropriate terraform scripts have been for provisioning the necessary infrastructure e.g VPC, Subnets, Security groups, EKS cluster, EKS worker groups e.t.c and then deploying our image from the container repository to our EKS cluster.

We can simply deploy our application following the simple steps below;

```sh
terraform init
```
- This helps you to initialize a working directory containing Terraform configuration files and installs the providers defined in the configuration.

```sh
terraform plan
```
- This creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.

```sh
terraform apply
```
- This executes the actions proposed in our Terraform plan.

## Explaining the terraform configuration files

| File | Function |
| ------ | ------ |
| var.tf | We specify our AWS Access key and Secret keys for our AWS profile where we would be hosting this application. |
| main.tf | We specify our preferred region and retrieve the list of availability zones in the region |
| vpc.tf| Using this file, we utilise AWS VPC module to create our VPC, subnets, specify our CIDR range. In our file, we are creating 3 public and private subnets. We also enabled NAT gateway and DNS hostname. |
| awssecuritygrp.tf  | Using this file, we create 2 security groups, we would also be having 2 worker nodes group. We are allowing access via port 22(ssh). 
 |
| eks-cluster.tf | Using this file,  we create our EKS cluster, worker groups and specify the number of instances and also mapping our worker groups to our earlier created security group. |
| kubernetes.tf | In this file, we set our newly created EKS cluster as the host and specify our authentication token and cluster ca certificate. Then we process to create a deployment and service for our application using our earlier created image. |
| output.tf | We use this file to output the details of the cluster and also of our load balancer that our application can be reached from. |

## Accessing our application

We can easily access our application using our load balancer url. Our application is to return the raw data, in JSON format, passed in the request body.

```sh
<loadbalancerurl/ping>
<loadbalancerurl//query?someKey=someValue>
<loadbalancerurl/post>
```


