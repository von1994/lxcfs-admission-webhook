#!/bin/bash
docker build -t local.harbor.io/library/lxcfs:3.1.2 lxcfs-image
docker push local.harbor.io/library/lxcfs:3.1.2

./build
