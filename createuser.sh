for i in {4..70};
do 
  htpasswd -B -b localusers user$i SFXRnUwJsERovopd;
done;