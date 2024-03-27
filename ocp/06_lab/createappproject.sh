#!/bin/bash

argocd login \
  --insecure \
  --grpc-web $(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath='{.spec.host}{"\n"}') \
  --username admin \
  --password $(oc get secret/openshift-gitops-cluster -n openshift-gitops -o jsonpath='{.data.admin\.password}' | base64 -d);

for i in {1..70};
do 
  argocd proj create user$i -d https://kubernetes.default.svc,user$i;
  argocd proj set user$i --src '*'
  argocd proj allow-cluster-resource user$i '*' '*'
done;