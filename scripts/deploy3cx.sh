#!/bin/bash
public_ip=$1
fqdn=$2
mkdir 3cx
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
  -v    /root/3cx:/mnt/3cx \
  --env CX_PUBLIC_IP=$public_ip \
  --env CX_INTERNAL_FQDN=$fqdn \
          ghcr.io/izer-xyz/3cx:latest
