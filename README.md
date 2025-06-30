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

## Deployment
* make sure you have a host for this project, lots of services want SSL
* fork the repo (you will need this for argocd)
* pick a provider in the infra folder and follow the instructions there
* follow the readme in the bootstrap-data-platform folder
* make sure all the services are running
* deploy the Airflow DAGs
