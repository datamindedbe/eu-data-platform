* log into Zitadel
  * credentials in `apps/600-zitadel/values.yaml` 
  * create a new Service User 
    * create a key for it
    * download this key, and save it in your cloud provider folder (the relevant readme will tell you where)
* switch to production let's encrypt certificates
  * in `apps/100-traefik/values.yaml` change `caServer` 