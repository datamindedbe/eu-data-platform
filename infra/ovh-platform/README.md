1. To set up terraform, go here
https://www.ovh.com/auth/api/createToken?GET=/*&POST=/*&PUT=/*&DELETE=/*

and export the following env variables:
```
export OVH_CONSUMER_KEY=79444139c76f61b4197ad55326c03f82
export OVH_APPLICATION_KEY=32ecebe15d50bf6b
export OVH_APPLICATION_SECRET=7b33f3cfbbc9a9d30ec3b3698b0f4875
```

2. Adjust your project id in `k8s/vars.tf`
3. run `tf apply` in `k8s`





[//]: # (- Generate a `jwt_token` in the [Zitadel UI]&#40;https://zitadel.scaleway.playground.dataminded.cloud/ui/console/org&#41; for programmatic access)