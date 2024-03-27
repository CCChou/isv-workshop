#!/bin/bash

MYPROJECT=$(oc project -q)

oc get deployment -n user1 | awk 'NR==2 {print $1}' | sed 's/^[ \t]*//;s/[ \t]*$//'