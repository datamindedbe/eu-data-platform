- Couldn't get the Object storage backend working, most probably the s3 backend is doing something funky that is not supported on upcloud
  - even this link https://upcloud.com/blog/terraform-best-practices-beginners/ does not mention anything about storing the tf state in upcloud
- export UPCLOUD_USERNAME and UPCLOUD_PASSWORD as env variables
- run terraform apply in the `k8s` folder
  - after this, you should have a k8s cluster. The kubeconfig file is in the k8s folder, named `.kubeconfig.yml`
  - export the kubeconfig env variable `export KUBECONFIG=\`pwd\`/.kubeconfig.yml`

