# AWS Web Application Hosting Environment

## Overview

This project aims to create a robust, secure, and scalable hosting environment on Amazon Web Services (AWS) for a simple web application. The web application consists of a single page containing the creator's name.

## Design

The architecture is designed using various AWS services and components to ensure reliability, security, and scalability. The key components include:

- **AWS Cloud9 Environment:** A cloud-based integrated development environment (IDE) to facilitate the development and management of AWS resources.

- **CloudFormation Stack:** Defines the infrastructure using a CloudFormation template (`stack.yaml`) that includes:
  - Security Groups
  - Launch Template
  - Target Group
  - Application Load Balancer (ALB)
  - Auto Scaling Group

- **EC2 Instances (Auto Scaling):** Instances that host the web application, dynamically scaling based on demand.

## Why These Services?

### AWS Cloud9
AWS Cloud9 provides a collaborative and cloud-based IDE, streamlining the development and management of AWS resources. It offers a consistent environment for code editing and execution.

### CloudFormation
CloudFormation enables infrastructure as code (IaC) by defining and provisioning AWS infrastructure in a safe, repeatable manner. It simplifies resource management and ensures consistency across deployments.

### EC2 Instances with Auto Scaling
EC2 instances are used to host the web application, and Auto Scaling ensures that the application can handle varying workloads by dynamically adjusting the number of instances based on demand.

### ALB and Target Group
The Application Load Balancer (ALB) distributes incoming traffic across multiple EC2 instances for high availability and load balancing. The Target Group defines how traffic is routed to specific instances.

## How They Work Together

1. **Cloud9 Environment Setup:**
   - A Cloud9 environment is created using AWS Cloud9, facilitating collaborative development.

2. **CloudFormation Stack Deployment:**
   - The CloudFormation stack is deployed using the defined `stack.yaml` template, creating security groups, launch templates, target groups, ALB, and an Auto Scaling group.

3. **EC2 Instances and Auto Scaling:**
   - EC2 instances are launched within the Auto Scaling group, ensuring that the web application is available and scales based on demand.

4. **ALB and Target Group Configuration:**
   - The ALB is configured to distribute incoming traffic to the instances through the defined Target Group, providing high availability and load balancing.

## Getting Started

Follow these steps to set up the hosting environment:
1. Ensure you have an AWS account.
2. Open AWS Cloud9 and create a new environment.
3. Deploy the CloudFormation stack using the provided `stack.yaml` template.
4. Review the CloudFormation console to ensure successful resource creation.
5. Access your web application through the ALB DNS or within the Cloud9 environment.

## Conclusion

This project demonstrates how to leverage AWS services to create a scalable and secure hosting environment for a web application. It serves as a foundation for more complex architectures and provides hands-on experience with key AWS tools.

Happy coding in the cloud!
