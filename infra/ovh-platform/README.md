# OVH Platform

## Prerequisites
Make sure you have an OVH account.

## Getting started
1. To set up terraform, go here
https://www.ovh.com/auth/api/createToken?GET=/*&POST=/*&PUT=/*&DELETE=/*

and export the following env variables:
```
export OVH_CONSUMER_KEY=
export OVH_APPLICATION_KEY=
export OVH_APPLICATION_SECRET=
```

2. Adjust your project id in `k8s/vars.tf`
3. run `tf apply` in `k8s`
4. follow the instructions in `bootstrap-data-platform`
5. run `tf apply` in `data-platform`
6. in the OVH console, find the database created (dp) and reset the admin password 
7. create a file called `terraform.tfvars` with the following contents
```text
pg_admin_password = "YOUR PASSWORD HERE"
pg_admin_user = "avnadmin"
```
8. run `tf apply` again so it sets the zitadel credentials correctly
9. after this, zitadel should be up and running


In order to create OIDC resources for Zitadel, you need to create a jwt_token in the Zitadel UI (e.g. https://zitadel.ovh.playground.dataminded.cloud/ui/console/org).
- Go to the service users tab and create a new service user. ![Create service user](../../docs/CreateZitadelServiceUser.png)
- For this service user, create a key, Zitadel will create the json key that you need for the Terraform provider. ![Create Key Service user](../../docs/CreateKeyForZitadelServiceUser.png)
- Put the key in the zitadel directory as `token.json`

10. Replace the zitadel organization_id in `zitadel/app.tf` with the organization ID from the Zitadel UI.
11. run `tf apply` in the `zitadel` directory to create the OIDC resources for Zitadel.