# Strapi Blue/Green Deployment with AWS ECS, CodeDeploy, and CI/CD

This repository demonstrates the deployment of a Strapi application using a **Blue/Green deployment strategy** on AWS. The setup leverages **Amazon ECS (Elastic Container Service)**, **AWS CodeDeploy**, and **GitHub Actions** for continuous integration and deployment (CI/CD). This guide walks through the process of Dockerizing the Strapi app, pushing the Docker image to **Amazon ECR**, and setting up a fully automated deployment pipeline that switches traffic between Blue and Green environments.

## Features

- **Dockerized Strapi Application**: Build and push a Docker image for the Strapi backend.
- **CI/CD with GitHub Actions**: Build and deploy the Strapi app using GitHub Actions.
- **Amazon ECR**: Store Docker images securely in Amazon Elastic Container Registry (ECR).
- **AWS ECS with Blue/Green Deployment**: Set up ECS services with Blue/Green deployment for zero-downtime updates.
- **AWS CodeDeploy**: Handle the deployment process with automatic rollback on failure.
- **Automatic Traffic Routing**: Route traffic between Blue and Green environments using an AWS Application Load Balancer (ALB).

## Prerequisites

- **AWS Account**: You must have an AWS account with access to ECS, CodeDeploy, ECR, and ALB.
- **GitHub Repository**: A GitHub repository with the Strapi app and Dockerfile.
- **AWS CLI**: Installed and configured with proper IAM credentials.
- **GitHub Secrets**: Set up the necessary secrets in GitHub Actions for AWS access.

## Setup

### 1. Dockerize Strapi Application

Ensure that your Strapi application has a valid `Dockerfile` that builds a Docker image for your app.

### 2. Push Docker Image to Amazon ECR

- Create an ECR repository if you haven't already.
- Push your Docker image to Amazon ECR with the GitHub commit SHA as the tag.

### 3. Set Up AWS ECS and CodeDeploy

- **Create ECS Cluster**: Set up an ECS cluster to host your Strapi containers.
- **Define ECS Task**: Create an ECS task definition that specifies the Docker container details.
- **Create ECS Service**: Set up an ECS service linked with AWS CodeDeploy.
- **Set Up CodeDeploy Application**: Create a CodeDeploy application and deployment group.
- **Set Up ALB Target Groups**: Create Blue and Green target groups for ALB routing.
- **Configure CodeDeploy Deployment Group**: Set up deployment strategy (e.g., `CodeDeployDefault.ECSCanary10Percent5Minutes`).

### 4. Configure GitHub Actions CI/CD

The CI/CD pipeline is defined in the `cd-bluegreen-deploy.yml` file, which handles both the infrastructure setup and the deployment process.

### 5. GitHub Secrets

Add the following secrets to your GitHub repository:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID.
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key.
- `AWS_REGION`: The AWS region you're using (e.g., `us-east-1`).
- `ECR_IMAGE_URI`: The URI of your ECR Docker image.

### 6. Trigger Deployment

Once the GitHub Actions workflow is set up, trigger the deployment by providing the Docker image URI as an input in the GitHub Actions workflow.

## Deployment Process

1. **Build Docker Image**: When changes are pushed to the repository, the Docker image is built and tagged with the GitHub commit SHA.
2. **Push to ECR**: The Docker image is pushed to Amazon ECR.
3. **Update ECS Task Definition**: The ECS task definition is updated with the new image tag.
4. **Blue/Green Deployment**: CodeDeploy manages the deployment process. It updates the ECS service with the new task definition, switches traffic from the Blue environment to the Green environment, and rolls back in case of failure.
5. **Automatic Rollback**: If the deployment fails, CodeDeploy will automatically roll back to the previous stable version.

## Security & Networking

- Ensure the **ALB security group** allows traffic on **ports 80** (HTTP) and **443** (HTTPS).
- Configure **IAM roles** and policies with the necessary permissions for ECS, CodeDeploy, and ALB.
- Make sure to securely manage your AWS credentials through GitHub Secrets.

## Verification

After deployment, test that:

- The Strapi app is accessible without downtime.
- Traffic switches seamlessly from Blue to Green.
- In case of failure, the system rolls back to the previous version (Blue environment).

## Contributing

Feel free to fork this repository, make improvements, or submit issues and pull requests. Contributions are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

