#!/bin/bash
fqdn=$1
public_ip=$2
script="deploy.sh"
logfile="/var/log/jps-3cx-install.log"
echo "[$script] Creating directories" >> $logfile
mkdir -p /root/3cx/mount
mkdir -p /root/3cx/config
chown -R docker. /root/3cx
echo "[$script] Deploying container on IP [$public_ip] and URL [$fqdn]"  >> $logfile
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
  -p      9000-9200:9000-9200 \
  -v    /root/3cx/mount:/mnt/3cx \
  -v    /root/3cx/config:/etc/3cxpbx \
  --env CX_PUBLIC_IP=$public_ip \
  --env CX_INTERNAL_FQDN=$fqdn \
  --name 3cx \
  --restart unless-stopped \
          ghcr.io/izer-xyz/3cx:latest
echo "[$script] Docker deployment complete" >> $logfile
