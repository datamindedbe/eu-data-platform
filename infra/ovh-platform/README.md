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