#!/bin/bash

yum install -y java-17-openjdk git wget vim podman

for i in {1..20};
do 
  useradd -m user$i && echo "user$i:LJvFJi536yJutvLR" | chpasswd;
done;