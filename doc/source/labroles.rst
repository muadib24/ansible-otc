Roles for lab (on migration)
----------------------------

+------------------------+-------------------------------------------------+
| role                   | description                                     |
+========================+=================================================+
| dns_transfer		 | transfer a DNS zone                             |
+------------------------+-------------------------------------------------+
| elb                    | list elastic loadbalancers                      |
+------------------------+-------------------------------------------------+
| elb_create             | create elastic loadbalancer                     |
+------------------------+-------------------------------------------------+
| elb_delete             | delete elastic loadbalancer                     |
+------------------------+-------------------------------------------------+
| elb_show               | show elastic loadbalancer                       |
+------------------------+-------------------------------------------------+
| elb_certificate        | show elastic loadbalancer certificates          |
+------------------------+-------------------------------------------------+
| elb_certificate_create | create elastic loadbalancer certificate         |
+------------------------+-------------------------------------------------+
| elb_certificate_delete | delete elastic loadbalancer certificate         |
+------------------------+-------------------------------------------------+
| elb_healthcheck_create | create elastic loadbalancer healthcheck         |
+------------------------+-------------------------------------------------+
| elb_healthcheck_delete | delete elastic loadbalancer healthcheck         |
+------------------------+-------------------------------------------------+
| elb_healthcheck_show   | show elastic loadbalancer healthcheck           |
+------------------------+-------------------------------------------------+
| elb_listener           | list listener for elastic loadbalancer          |
+------------------------+-------------------------------------------------+
| elb_listener_create    | create listener for elastic loadbalancer        |
+------------------------+-------------------------------------------------+
| elb_listener_delete    | delete listener from elastic loadbalancer       |
+------------------------+-------------------------------------------------+
| elb_backends           | list backends for elastic loadbalancer          |
+------------------------+-------------------------------------------------+
| elb_backends_create    | create backends for elastic loadbalancer        |
+------------------------+-------------------------------------------------+
| elb_backends_delete    | delete backends for elastic loadbalancer        |
+------------------------+-------------------------------------------------+
| job                    | show job status                                 |
+------------------------+-------------------------------------------------+
| lookup_name            | lookup id by name                               |
+------------------------+-------------------------------------------------+
| os-client-config.yml   | create os-client-config yml file                |
+------------------------+-------------------------------------------------+
| rds_versions 		 | list provided database versions for RDS         |
+------------------------+-------------------------------------------------+
| rds_flavors		 | list provid flavor for selected version in RDS  |
+------------------------+-------------------------------------------------+
| token                  | get auth token                                  |
+------------------------+-------------------------------------------------+

Starting up
-----------

::

    cp secrets.yml  _secrets.yml 

  
**adjust your own data in this file before you using the examples:**

list elastic loadbalancers::

    ansible-playbook  elb.yml

create elastic loadbalancer (tenant.ini)::

    ansible-playbook  elb_create.yml -e "elb_name=ansible-elb01"

delete elastic loadbalancer::

    ansible-playbook  elb_delete.yml -e "elb_name=ansible-elb01"

show elastic loadbalancer::

    ansible-playbook  elb_show.yml -e "elb_name=ansible-elb01"

list elastic loadbalancer certificates::

    ansible-playbook  elb_certificate.yml 

create elastic loadbalancer certificate (we hate comments in cert file)::

    ansible-playbook  elb_certificate_create.yml -e "elb_certificate_name=ansible-cert elb_certificate_key_file=cert.key elb_certificate_certificate_file=cert.crt" 

delete elastic loadbalancer certificates::

    ansible-playbook  elb_certificate_delete.yml -e "listener_certificate_name=ansible-cert"

create elastic loadbalancer healthcheck (tenant.ini)::

    ansible-playbook  elb_healthcheck_create.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01"

delete elastic loadbalancer healthcheck::

    ansible-playbook  elb_healthcheck_delete.yml -e "elb_healthcheck_id=e12454b93f304b759be699cb0270648c"

show elastic loadbalancer healthcheck::

    ansible-playbook  elb_healthcheck_show.yml -e "elb_healthcheck_id=e12454b93f304b759be699cb0270648c"

list listener for elastic loadbalancer::

    ansible-playbook  elb_listener.yml -e "elb_name=ansible-elb01"

create listener for elastic loadbalancer (tenant.ini)::

    ansible-playbook  elb_listener_create.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01"

delete listener for elastic loadbalancer::

    ansible-playbook  elb_listener_delete.yml -e "elb_name=ansible-elb01"  -e "listener_name=ansible-listener03"

list backends for elastic loadbalancer (tenant.ini)::

    ansible-playbook  elb_backends.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" 

create backends for elastic loadbalancer::

    ansible-playbook  elb_backends_create.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" -e "ecs_name=ansible-test01" -e "ecs_address=192.168.0.10"

delete backends for elastic loadbalancer::

    ansible-playbook  elb_backends_delete.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" -e "elb_backends_id=d15e2f8dd7d64d95a6b5c2a791cac408"

show job status::

    ansible-playbook -e "job_id=2c9eb2c15693b00901571e32ad5e1755"  job.yml

    ./ajob 2c9eb2c15693b00901571e32ad5e1755

lookup id by name (image)::

    ansible-playbook  lookup_name.yml -e "image_name=Community_Ubuntu_16.04_TSI_latest"

lookup id by name (flavor)::

    ansible-playbook  lookup_name.yml -e "ecs_ram=2048" -e "ecs_vcpus=4"

lookup id by name (subnet)::

    ansible-playbook  lookup_name.yml -e "subnet_name=subnet-5831"

lookup id by name (secgroup)::

     ansible-playbook  lookup_name.yml -e "secgroup_name=bitnami-wordpress-56a9-securitygroup"

lookup id by name (vpc)::

     ansible-playbook  lookup_name.yml -e "vpc_name=vpc-4988"

lookup id by name (eip)::

     ansible-playbook  lookup_name.yml -e "public_ip_address=160.44.1.1"
  
lookup id by name (zone)::

     ansible-playbook  lookup_name.yml -e "zone_name=example.com."

lookup id by name (ecs)::

     ansible-playbook  lookup_name.yml -e "ecs_name=ansible-test01"

lookup id by name (evs)::

     ansible-playbook  lookup_name.yml -e "evs_name=ansible-evs01"

lookup id by name (elb)::

     ansible-playbook  lookup_name.yml -e "elb_name=ansible-elb01"

lookup id by name (certificate)::

     ansible-playbook  lookup_name.yml  -e "listener_certificate_name=ansible-cert"

lookup id by name (listener)::

     ansible-playbook  lookup_name.yml  -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01"

list provided database versions for RDS::

    ansible-playbook  rds_versions.yml

list provided flavors for selected database version in RDS::

     ansible-playbook  rds_flavors.yml -e "rds_version_id=286a34fc-a605-11e6-88fd-286ed488c9cb"

Full Working Example
--------------------

configure your VM in tenant.ini and run all necessary roles to bootstrap a VM::

    ansible-playbook  tenant_create.yml -e "ecs_name=ansible-test01"

This playbook will create VPC,Subnet, SecurityGroup, SSH-Keypair, allocate Floating-IP and boostrap the VM.

transfer your private dns zones to OTC using zone transfer (data stored in data.ini, needs zone transfer rights on dns_server)::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=internal.example.com" -e "zone_type=private" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"

transfer your public dns zones to OTC using zone transfer::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=external.example.com" -e "zone_type=public" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"
