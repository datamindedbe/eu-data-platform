# Data Platform Stack

* relies on open source components such as
  * Trino
  * Airflow
  * Open Policy Agent
  * Hashicorp Vault
  * ArgoCD
  * Zitadel
* runs on managed Kubernetes services from a couple of EU-based providers
  * OVH
  * Scaleway
  * UpCloud
  * Exoscale


## Architecture
![Architecture](docs/architecture.png)
The core of the platform is a Trino cluster, providing a SQL-like interface to data. This is used by
* data engineers who can query the data via a database client 
* jobs scheduled by Airflow

Supporting components:
* Zitadel - for single sign on
* ArgoCD - for application deployment
* Vault - for secrets management
* Open Policy Agent - for authorization of Trino queries

## Interacting with the Platform
The Data Engineers interact with the platform via the Airflow UI and via a database client connecting to Trino.

# Deploying the platform
## Tools needed
* terraform
* kubectl
* helm

## Requirements
* make sure you have a hostname for this project, lots of services want SSL
* fork this repo because you will need to change some values
* pick a cloud provider and make sure you can authenticate terraform (you can run this locally, but it is tricky to get the SSL certificates right)
  * OVH https://registry.terraform.io/providers/ovh/ovh/latest
  * UpCloud https://registry.terraform.io/providers/UpCloudLtd/upcloud/latest
  * Scaleway https://registry.terraform.io/providers/scaleway/scaleway/latest
  * Exoscale https://registry.terraform.io/providers/exoscale/exoscale/latest
  * It is possible to run this on Hetzner + Cloudfleet (this combo only gives you k8s and object store, no managed databases)

## Infra deployment
* pick a provider in the `infra` folder and follow the instructions there
* follow the readme in the `bootstrap-data-platform` folder
* if needed, continue bootstrapping the platform with the relevant infra provider (databases, credentials etc)
* follow the readme in the argo folder

## Deploy some ETL jobs
* deploy the Airflow DAGs
