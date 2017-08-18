# ansible slurm

An ansible playbook to install slurm for Birdhouse demo.

## Install slurm

Run playbook with defaults:

  $ ansible-playbook playbooks/slurm.yml

Run playbook with `slurm` hostname:

  $ ansible-playbook playbooks/slurm.yml -e slurm_server_name=slurm


## Links

* https://galaxy.ansible.com/list#/roles?page=1&page_size=10&autocomplete=slurm
* https://github.com/grycap/ansible-role-slurm
* http://pvh.wp.sanbi.ac.za/2013/12/02/installing-slurm-on-centos-using-ansible/
* https://www.slothparadise.com/how-to-install-slurm-on-centos-7-cluster/
