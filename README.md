# Falco/Argo Events container isolation

## Introduction
This project leverages the power of [Falco](https://falco.org/) and [Argo Events](https://argoproj.github.io/argo-events/) to enhance the security posture of Kubernetes clusters. This initiative focuses on identifying potential security threats within Kubernetes and automatically mitigating these threats. Our approach integrates the real-time monitoring capabilities of Falco with the event-driven automation of Argo Events, forming a robust defense mechanism against security vulnerabilities in Kubernetes environments.


## Features
- (**cloudtrail-falco-integration**)[cloudtrail-falco-integration]: As Falco is used in this project to monitor both the Kubernetes cluster and the AWS account, it is required to set up a few resources in the AWS account so Falco can read its events. This is a Terraform module to export CloudTrail events to an S3 Bucket.
- (**thread-detection-falco-os**)[thread-detection-falco-os]: An automated installation of Falco to make things easier.

## Requiments
The following is required to run this project properly:
- [Terraform](https://developer.hashicorp.com/terraform/install?product_intent=terraform)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [Helm](https://helm.sh/docs/helm/helm_install/)
- An AWS Account with EKS. The nodes (or at least the Falco pods through [IRSA](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)) need access to the SQS Queue and the S3 bucket created in the (cloudtrail-falco-integration)[cloudtrail-falco-integration].

## Usage
- Clone the repo
- Use the (cloudtrail-falco-integration)[cloudtrail-falco-integration] example to deploy the required resources to export events from Cloudtrail to S3
- Use the (thread-detection-falco-os)[thread-detection-falco-os] to install Falco in the EKS Cluster. A simple `make install` will do it (as long as all the other requirements are in-place)

## License
This project is distributed under GNU GPLv3. See [LICENSE](LICENSE).
