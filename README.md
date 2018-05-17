# birdhouse-ansible
Ansible playbooks for Birdhouse installation.

## Available Ansible Playbooks

* Demo deployment of Emu PyWPS application: moved to https://github.com/bird-house/ansible-wps-playbook
* slurm/ - Demo deployment of PyWPS with Slurm scheduler.
* sge/ - Demo Deployment of PyWPS with GridEngine scheduler.

## Install Ansible

Install Ansible via conda:

    $ conda install -c conda-forge ansible

## Test Ansible using docker container

Run Ansible in docker container:

    $ docker run -it --rm -v /home/pingu/sandbox/birdhouse/birdhouse-ansible:/opt/ansible debian /bin/bash
    > cd /opt/ansible
    > bash bootstrap.sh -i -p /opt/conda
    > export PATH=/opt/conda/bin:$PATH
    > cd gridengine
    > ansible-playbook playbooks/gridengine.yml

## Links

* http://docs.ansible.com/ansible/latest/playbooks.html
* https://github.com/enginyoyen/ansible-best-practises
