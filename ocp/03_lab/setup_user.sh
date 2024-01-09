#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 'Usage sh 03_setup.sh [user_count]'
  exit 1
fi

USER_COUNT=$1
for i in $(seq 1 $USER_COUNT)
do
  oc new-project user$i
  oc adm policy add-role-to-user admin user$i -n user$i
  oc adm policy add-cluster-role-to-user cluster-monitoring-operator user$i
  oc adm policy add-cluster-role-to-user cluster-monitoring-view user$i
  oc adm policy add-cluster-role-to-user cluster-logging-view user$i
  oc adm policy add-cluster-role-to-user cluster-logging-application-view user$i
  oc adm policy add-cluster-role-to-user cluster-logging-infrastructure-view user$i
  oc adm policy add-cluster-role-to-user cluster-logging-audit-view user$i
  
done