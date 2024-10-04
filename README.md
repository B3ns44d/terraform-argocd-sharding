# Terraform ArgoCD Sharding Setup

This repository provides a Terraform-based solution to implement **ArgoCD sharding** for managing large-scale Kubernetes deployments. Sharding distributes the workload of reconciling applications across multiple ArgoCD controllers, ensuring better performance and scalability when managing hundreds or thousands of applications.

## Features

- Shards ArgoCD application controllers across multiple namespaces.
- Dynamic generation of namespace-to-shard assignments using Open Policy Agent (OPA) Gatekeeper.
- Configurable services, endpoints, and RBAC for each shard.
- Supports dynamic scaling based on the number of shards and namespaces.

### Requirements
- **Terraform v1.8.5 or higher**
- **Kubernetes Cluster**
- **ArgoCD installed in the Kubernetes cluster**
- **OPA Gatekeeper installed in the Kubernetes cluster**

### Variables

- **shards**: Mapping of shard names to assigned namespaces.
- **shard_list**: List of all shard names.
- **argocd_namespace**: The namespace where ArgoCD is deployed.
- **kubernetes_api_endpoints**: List of Kubernetes API server endpoints.
- **kubernetes_host**: The Kubernetes API server endpoint.
- **kubernetes_token**: Token for authentication to the Kubernetes API.
- **argocd_server_addr**: Address of the ArgoCD server.
- **argocd_username**: Username for ArgoCD authentication.
- **argocd_password**: Password for ArgoCD authentication.

### Usage

Clone the repository:

```bash
git clone https://github.com/B3ns44d/terraform-argocd-sharding.git
cd terraform-argocd-sharding
```

Update the `example.tfvars` file with your own values:

```hcl
shards = {
  shard-01 = ["namespace1", "namespace2"]
  shard-02 = ["namespace3", "namespace4"]
}

shard_list = ["shard-01", "shard-02"]

kubernetes_api_endpoints = ["0.0.0.0", "0.0.0.0"]
argocd_namespace         = "argocd"
kubernetes_host          = "https://192.168.1.10"
kubernetes_token         = "your_kubernetes_token"
argocd_server_addr       = "https://argocd.example.com"
argocd_username          = "admin"
argocd_password          = "your_argocd_password"
```

Initialize the project:

```bash
terraform init
```

Run a plan to preview the changes:

```bash
terraform plan -var-file="example.tfvars"
```

Apply the changes:

```bash
terraform apply -var-file="example.tfvars"
```

### Outputs

- **argocd_cluster_names**: List of registered ArgoCD cluster names.