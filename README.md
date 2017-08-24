# birdhouse-ansible
Ansible playbooks for Birdhouse installation.

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
