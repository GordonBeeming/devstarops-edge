podman stop -a

podman run -p 80:80 -p 433:433 --name server --rm -d -v $PWD/nginx.conf:/etc/nginx/nginx.conf -v $PWD/reverse-error.log:/var/log/nginx/reverse-error.log -v $PWD/reverse-access.log:/var/log/nginx/reverse-access.log -v $PWD/access.log:/var/log/nginx/access.log -v $PWD/error.log:/var/log/nginx/error.log -v $PWD/portal/:/var/portal/ localhost/site:latest

podman exec -it 333be4f4c1c132906086628008c69c1c9606f03d474e70edfedf18e12666d235 /usr/sbin/nginx -s reload


podman run -p 80:80 -p 433:433 --name edge --restart unless-stopped --replace --tls-verify --pull always -d ghcr.io/devstarops/devstarops-edge:main