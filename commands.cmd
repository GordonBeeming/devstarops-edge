podman stop -a

podman build -f .\Containerfile -t edge

podman run -p 8102:80 --name edge --replace --rm -d -v nginx.conf:/etc/nginx/nginx.conf -v access.log:/var/log/nginx/access.log -v error.log:/var/log/nginx/error.log -v edge:/var/edge/ localhost/edge:latest

podman run -p 80:80 -p 443:443 --name server --rm -d -v $PWD/nginx.conf:/etc/nginx/nginx.conf -v $PWD/reverse-error.log:/var/log/nginx/reverse-error.log -v $PWD/reverse-access.log:/var/log/nginx/reverse-access.log -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v $PWD/portal/:/var/portal/ localhost/site:latest

sudo podman exec -it 0fd30cba2e8d7558af1de0940e76c18f86f5380126ec7f60f519eb9636dc3ece /usr/sbin/nginx -s reload

sudo podman exec -it 87d871c2de8e4d73d89278357c38e39db7feb5ac3a8824350b938edf55ca144e /var/log/nginx | ls

podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d ghcr.io/devstarops/devstarops-edge:main

sudo podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v /var/edge/nginx.conf:/etc/nginx/nginx.conf -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v /var/edge/:/var/edge/ ghcr.io/devstarops/devstarops-edge:main

podman run -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v nginx.conf:/etc/nginx/nginx.conf -v access.log:/var/log/nginx/access.log -v error.log:/var/log/nginx/error.log -v edge:/var/edge/ ghcr.io/devstarops/devstarops-edge:main