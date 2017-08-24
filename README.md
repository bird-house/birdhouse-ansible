# birdhouse-ansible
Ansible playbooks for Birdhouse installation.

## Install Ansible

Install ansible via conda:

    $ conda install -c conda-forge ansible

## Run Ansible in docker

Run ansible in docker container:

    $ docker run -it --rm -v /home/pingu/sandbox/birdhouse/birdhouse-ansible:/opt/ansible ubuntu /bin/bash
    > cd /opt/ansible
    > ./bootstrap.sh

## Links

* http://docs.ansible.com/ansible/latest/playbooks.html
* https://github.com/enginyoyen/ansible-best-practises
