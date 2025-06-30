# Bootstrap ArgoCD

This directory contains the configuration to bootstrap ArgoCD onto the Kubernetes cluster.
We will use ArgoCD to deploy the rest of the Data Platform stack.

## Steps
0.  **Adjust hostnames and git repo:**
    - replace https://argocd.ovh.playground.dataminded.cloud with whatever hostname you want to use for this project 
    - in the root-app.yaml file, replace the git repo with the URL of your git repo

1.  **Define Namespace, ArgoCD Resources, and Ingress:**
    - The `namespace.yaml` file explicitly defines the `argocd` namespace.
    - The `argocd-ingress.yaml` file defines an Ingress resource to expose the ArgoCD UI via Traefik (using HTTPS) 
    - The `kustomization.yaml` file includes `namespace.yaml`, `argocd-ingress.yaml`, and references the official stable ArgoCD installation manifests.

2.  **Apply the Configuration:**
    To install ArgoCD, run the following command from the root of the repository (`dp-stack`):
    ```bash
    kubectl apply -k bootstrap-data-platform
    ```
    This command uses Kustomize (via `kubectl`) to apply the manifests defined in `bootstrap/kustomization.yaml` (including the namespace, ArgoCD manifests, and the Ingress) to your currently configured Kubernetes cluster.

3.  **Apply the Root Application:**
    Once ArgoCD is running, apply the root application manifest. This tells ArgoCD to manage other applications defined in your Git repository (`argo/apps` directory).
    ```bash
    kubectl apply -f bootstrap/root-app.yaml -n argocd
    ```
