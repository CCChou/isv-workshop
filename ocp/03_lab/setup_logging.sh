#!/bin/bash

oc apply -f https://raw.githubusercontent.com/CCChou/OpenShift-PoC-Scenario/main/03_Operation/04_logging_loki/yaml/loki-stack.yaml
oc apply -f https://raw.githubusercontent.com/CCChou/OpenShift-PoC-Scenario/main/03_Operation/04_logging_loki/yaml/clusterlogging-loki.yaml