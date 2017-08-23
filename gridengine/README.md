# ansible gridengine

An ansible playbook to install gridengine for Birdhouse demo.

## Install gridengine

Run playbook with defaults:

    $ ansible-playbook playbooks/gridengine.yml


## Test it with docker

Run ansible in docker container:

    $ docker run -it --rm -v /home/pingu/sandbox/birdhouse/birdhouse-ansible:/opt/ansible ubuntu /bin/bash
    > cd /opt/ansible
    > ./bootstrap.sh

## Links

* https://galaxy.ansible.com/grycap/sge/
* https://github.com/aabdulwahed/Sun-Grid-Engine-Ansible
* https://github.com/NLeSC/xenon-docker-images
