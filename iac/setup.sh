#!/bin/bash

# wget .tar.gz file -> extract cli -> move to bin and give execute permission
install_cli() {
  URL=$1
  ORI_NAME=$2
  NAME=$3
  TEMP_DIR=/tmp/cli
  
  mkdir $TEMP_DIR
  wget $URL -O $TEMP_DIR/$NAME.tar.gz
  tar zxf $TEMP_DIR/$NAME.tar.gz -C $TEMP_DIR/
  mv $TEMP_DIR/$ORI_NAME /usr/local/bin/$NAME
  chmod +x /usr/local/bin/$NAME
  rm -rf $TEMP_DIR
}

yum install -y java-17-openjdk git wget vim podman

# get oc, tkn, kn cli
install_cli https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable/openshift-client-linux.tar.gz oc oc
install_cli https://mirror.openshift.com/pub/openshift-v4/clients/pipeline/latest/tkn-linux-amd64.tar.gz tkn-linux-amd64 tkn
install_cli https://mirror.openshift.com/pub/openshift-v4/clients/serverless/latest/kn-linux-amd64.tar.gz kn kn

# change passowrd authentication to yes and restart sshd
sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
systemctl restart sshd

for i in {1..20};
do 
  useradd -m user$i && echo "user$i:LJvFJi536yJutvLR" | chpasswd;
done;