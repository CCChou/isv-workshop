#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 'Usage sh setup_user.sh [user_count]'
  exit 1
fi

USER_COUNT=$1
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-gitops:openshift-gitops-argocd-application-controller
for i in $(seq 1 $USER_COUNT)
do
  oc new-project user$i
  oc adm policy add-role-to-user admin user$i -n user$i
  oc adm policy add-cluster-role-to-user cluster-monitoring-operator user$i -n user$i
  oc adm policy add-cluster-role-to-user cluster-monitoring-view user$i -n user$i
done
