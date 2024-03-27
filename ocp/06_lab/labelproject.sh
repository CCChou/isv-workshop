#!/bin/bash

for i in {1..70};
do 
  oc label namespace user$i argocd.argoproj.io/managed-by=openshift-gitops;
done;
