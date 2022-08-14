podman stop -a

podman build -f .\Containerfile -t edge

podman run -p 8099:443 --name edge --replace --rm -d -v nginx.conf:/etc/nginx/nginx.conf -v access.log:/var/log/nginx/access.log -v error.log:/var/log/nginx/error.log -v edge:/var/edge/ localhost/edge:latest

podman exec -it 85bbea8e3512515c21f73a467e37fbe58766ec35bfc4c08940f0c2bec4190719 /usr/sbin/nginx -s reload

podman run -p 80:80 -p 443:443 --name server --rm -d -v $PWD/nginx.conf:/etc/nginx/nginx.conf -v $PWD/reverse-error.log:/var/log/nginx/reverse-error.log -v $PWD/reverse-access.log:/var/log/nginx/reverse-access.log -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v $PWD/portal/:/var/portal/ localhost/site:latest

sudo podman exec -it 87d871c2de8e4d73d89278357c38e39db7feb5ac3a8824350b938edf55ca144e /var/log/nginx | ls

podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d ghcr.io/devstarops/devstarops-edge:main

sudo podman run -p 80:80 -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v /var/edge/nginx.conf:/etc/nginx/nginx.conf -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v /var/edge/:/var/edge/ ghcr.io/devstarops/devstarops-edge:main

podman run -p 443:443 --name edge --restart unless-stopped --replace --tls-verify --pull always -d -v nginx.conf:/etc/nginx/nginx.conf -v access.log:/var/log/nginx/access.log -v error.log:/var/log/nginx/error.log -v edge:/var/edge/ ghcr.io/devstarops/devstarops-edge:main