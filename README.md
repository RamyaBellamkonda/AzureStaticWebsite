# Deploying a Static Website on Azure with Azure DevOps

This repository contains code and configurations for deploying a static website on Azure using Bicep templates through Azure DevOps pipelines. The deployment process is streamlined and automated to ensure efficient deployment of your static website.

## Table of Contents

- [Overview](#overview)
- [Infrastructure Setup](#infrastructure-setup)
- [Website Deployment](#website-deployment)
- [Deployment Strategy](#deployment-strategy)
- [Testing Infrastructure](#testing-infrastructure)
- [Azure DevOps Pipeline Setup](#azure-devops-pipeline-setup)
- [Usage](#usage)

## Overview

This project demonstrates how to deploy a static website on Azure using Bicep templates and Azure DevOps pipelines. The deployment process is designed to be automated and streamlined to ensure consistency and efficiency.

## Infrastructure Setup

- Create an Azure DevOps project and Git repository to store Bicep templates.
- Define Bicep templates to provision Azure resources:
  - Azure storage account
  - Azure CDN profile and endpoint
  - A web app to host the static website

## Website Deployment

- Configure Bicep templates to deploy static website files to a storage account.
- Implement configurations for hosting the static website, including storage account settings and enabling CDN.

## Deployment Strategy

- Implement a deployment strategy (e.g., blue-green or canary) to ensure seamless updates and minimal downtime.
- Configure the Azure DevOps pipeline to use the chosen deployment strategy during deployment.

## Testing Infrastructure

- Utilize Pester, a PowerShell testing framework, to validate deployed infrastructure.
- Create Pester tests to validate the correct deployment of the static website, including website content, CDN configuration, and overall functionality.

## Azure DevOps Pipeline Setup

- Configure an Azure DevOps pipeline using YAML to automate the deployment process.
- Set up the pipeline to trigger on changes to the Git repository and perform deployment steps using Bicep templates.

## Usage

1. Clone this repository to your local machine.
2. Customize the Bicep templates according to the project requirements.
3. Configure the Azure DevOps pipeline by creating a `azure-pipelines.yml` file.
4. Push your changes to the Git repository to trigger the Azure DevOps pipeline.
