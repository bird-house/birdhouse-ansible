#!/bin/bash
echo "Bootstrapping ..."

apt-get update -y && apt-get install -y curl bzip2

cd /root
curl -LO https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
bash Miniconda2-latest-Linux-x86_64.sh -b -p /opt/conda

export PATH=/opt/conda/bin:$PATH

conda install -y -c conda-forge ansible

echo "Bootstrapping done"
