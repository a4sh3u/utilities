#!/usr/bin/env bash
set -x
#docker network create test
docker run -itd --add-host nucleus.smava.de:0.0.0.0 --name design-system-app --network test artifactory.smava.de:6001/design-system:latest

sleep 5

cat << EOF > $(pwd)/htpasswd
ares:\$apr1\$ly5rHkSG\$Fb42UCsC4SLSqLYFNFYwP.
nginx:\$apr1\$wIjvKeWn\$cL9aMm50lPVvuPd9i8oQL/
EOF

docker run -itd -v $(pwd)/nginx_auth_based_on_source_ip.conf:/etc/nginx/conf.d/default.conf \
-v $(pwd)/htpasswd:/etc/nginx/htpasswd -p 80:80 --name nginx --network test linuxserver/nginx

set +x
