#!/bin/bash
public_ip=$1
fqdn=$2
echo "Creating directories" >> INSTALL_LOG
mkdir -p /root/3cx/mount
mkdir -p /root/3cx/config
mkdir -p /root/3cx/data
chown -R docker. /root/3cx
echo "Deploying container on IP [$public_ip] and URL [$fqdn]" >> INSTALL_LOG
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
  --env CX_PUBLIC_IP=$public_ip \
  --env CX_INTERNAL_FQDN=$fqdn \
  --name 3cx \
  --restart unless-stopped \
          ghcr.io/izer-xyz/3cx:latest
 echo "Deployment complete" >> INSTALL_LOG
