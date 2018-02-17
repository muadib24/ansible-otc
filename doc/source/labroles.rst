Roles for lab (on migration)
----------------------------

+------------------------+-------------------------------------------------+
| role                   | description                                     |
+========================+=================================================+
| dns_transfer		 | transfer a DNS zone                             |
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
