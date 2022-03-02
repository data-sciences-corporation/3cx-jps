#!/bin/bash
public_ip=$1
fqdn=$2
echo "Stopping current container" >> INSTALL_LOG
docker stop 3cx
echo "Removing previous _OLD version" >> INSTALL_LOG
docker rm 3cx_old
for image in `docker image list | grep '<none>' | awk '{print $3}'`; do docker rmi $image; done
echo "Renaming current version to _OLD" >> INSTALL_LOG
docker rename 3cx 3cx_old
echo "Get and run latest version of 3cx container on IP [$public_ip] and URL [$fqdn]" >> INSTALL_LOG
docker run \
  -d  \
  -t \
  --tmpfs /tmp \
  --tmpfs /run \
  --tmpfs /run/lock \
  -v      /sys/fs/cgroup:/sys/fs/cgroup:ro \
  -p      5015:5015 \
  -p      5000:5000 \
  -p      5001:5001 \
  -p      5060:5060 \
  -p      5060:5060/udp \
  -p      5090:5090 \
  -p      5090:5090/udp \
  -v    /root/3cx/mount:/mnt/3cx \
  -v    /root/3cx/config:/etc/3cxpbx \
  -v    /root/3cx/data:/var/lib/3cxpbx \
  --env CX_PUBLIC_IP=$public_ip \
  --env CX_INTERNAL_FQDN=$fqdn \
  --name 3cx \
  --restart unless-stopped \
          ghcr.io/izer-xyz/3cx:latest
 echo "Update complete" >> INSTALL_LOG
