oc adm groups new gitops-user;

for i in {1..70};
do 
  oc adm groups add-users gitops-user user$i;
done;