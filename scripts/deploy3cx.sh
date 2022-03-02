#!/bin/bash
public_ip=$1
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
  -v    /root/files/3cxpbx:/mnt/3cx \
  --env CX_PUBLIC_IP=102.23.205.26 \
  --env CX_INTERNAL_FQDN=docker.noxnoctua.com \
          ghcr.io/izer-xyz/3cx:latest
