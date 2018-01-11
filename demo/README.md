# Ansible Demo

This repository contains an example how to use Ansible for a PyWPS service.

## Deployment Scenarios

A PyWPS service may be used in the following deployment scenarios:

* testing and demo
  - might not have admin rights
  - nginx, supervisor and even gunicorn not necessary ... werkzeug/pywps has its own wsgi service which can be used for development.
  - support by ansible and buildout not necessary
  - just clone repo and setup conda environment
  - should just run with defaults ... no further configuration necessary.
* development on local laptop
  - no full installation necessary (skip Nginx, Supervisor, ...)
  - might not have admin rights
  - enabled debug mode
  - could be the same as the testing/demo variant.
* production ready installation on a single host
  - currently the default
  - can also be used as development environment.
* production installation on a cluster system
  - needs installation of slurm/grid-engine
  - see ansible slurm/grid-engine examples:
    https://github.com/bird-house/birdhouse-ansible
* docker container for testing and demo
  - We currently have a single container with PyWPS, Nginx, Supervisor
  - Container orchestration people don't like this :)
  - Wanted: micro-service + docker-compose
  - Quick-fix: just update the Dockerfile template and extend docker-compose configuration.
* docker container for orchestration
  - Kubernetes seems to be the favorite orchestration tool by admins.
  - Docker Swarm looks easier ... might be used for testing. But Docker support for Kubernetes is evolving.
  - Wanted: micro-service, a single PyWPS service without Nginx and Supervisor.

## Run Ansible Demo

This demo currently works only on Debin/Ubuntu. It will install the Emu PyWPS application on a single host including Nginx and Supervisor. Nginx, Supervisor and miniconda are installed on the System. The Emu PyWPS application is fetched from GitHub and dependencies are installed into a Conda environment.

### Bootstrap

Run bootstrap script (only once) to prepare your system and install Ansible:

    $ bash bootstrap.sh

### Run Ansible

Run Ansible via Makefile ... it will also fetch required roles/recipes from ansible-galaxy:

    $ make install

## Try in a Docker container

Make sure you are in the `ansible-demo/` folder.

Start an Ubuntu Docker container and mount local source:

    $ ./run_docker.sh

Run the Ansible deployment:

    $ ./bootstrap.sh
    $ make install

Check if application is started (supervisor):

    $ make status
    OR
    $ supervisorctl status

Run a WPS GetCapabilites request:

    $ curl -s -o caps.xml \
      "http://127.0.0.1:5000/wps?service=WPS&request=GetCapabilities"
    $ less caps.xml

Check log files:

    $ supervisorctl tail -f emu

Try more WPS requests:

    # show description of "hello" process
    $ curl -s -o out.xml \
      "http://127.0.0.1:5000/wps?service=WPS&request=DescribeProcess&version=1.0.0&identifier=hello"
    $ less out.xml

    # execute "hello" process
    $ curl -s -o out.xml \
      "http://127.0.0.1:5000/wps?service=WPS&request=Execute&version=1.0.0&identifier=hello&DataInputs=name=Spaetzle"
    § less out.xml

## Food for Thought

* Ansible and Buildout are not used for the same purpose ... there is a philosophy conflict. Ansible is on the system level (but it could just be localhost), Buildout is on the application level (localhost only). In Ansible examples packages (like Nginx, Supervisor, ...) are installed on the system (Debian, CentOS). In the current Birdhouse deployment solution with Buildout all packages and configs (besides Makefile, gcc, ...) are installed in the user space ... no admin rights are necessary and full installation can be wiped out easily. Probably need to combine best of both sides depending on the deployment scenario.
* Just a single Ansible deployment with configs for all birds? Or a minimal Ansible config in each bird repo fetching roles/recipes from ansible-galaxy?
* A PyWPS service can be run without the need of Ansible and Buildout ... just using a Werkzeug WSGI service and a minimal default configuration. Can be used for testing, demo and development. Need to figure out if current developers will like it :)
* We need to provide a PyWPS micro-service docker container. This should simplify the Docker installation drastically ... might be just a simple Dockerfile template. Complexity will be moved to docker-compose to wire micro-services to serve as a single web application. The other micro-services should be official images on docker-cloud.   

## Links

* https://tdhopper.com/blog/automating-python-with-ansible/
* https://plone-ansible-playbook.readthedocs.io/en/latest/index.html
* http://docs.ansible.com/ansible/latest/intro_installation.html
* https://galaxy.ansible.com/andrewrothstein/miniconda/
