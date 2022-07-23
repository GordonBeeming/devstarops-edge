podman stop -a

podman run -p 80:80 -p 443:443 --name server --rm -d -v $PWD/nginx.conf:/etc/nginx/nginx.conf -v $PWD/reverse-error.log:/var/log/nginx/reverse-error.log -v $PWD/reverse-access.log:/var/log/nginx/reverse-access.log -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v $PWD/portal/:/var/portal/ localhost/site:latest

sudo podman exec -it 5d6a4d4b568ff211381d867dcc612f1a972865226f58eff7e359e3d3c9551748 /usr/sbin/nginx -s reload

sudo podman exec -it 87d871c2de8e4d73d89278357c38e39db7feb5ac3a8824350b938edf55ca144e /var/log/nginx | ls

podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d ghcr.io/devstarops/devstarops-edge:main

sudo podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v /var/edge/nginx.conf:/etc/nginx/nginx.conf -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v /var/edge/:/var/edge/ ghcr.io/devstarops/devstarops-edge:main

podman run -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v nginx.conf:/etc/nginx/nginx.conf -v access.log:/var/log/nginx/access.log -v error.log:/var/log/nginx/error.log -v edge:/var/edge/ ghcr.io/devstarops/devstarops-edge:main