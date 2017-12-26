Roles for lab (on migration)
----------------------------

+------------------------+-------------------------------------------------+
| role                   | description                                     |
+========================+=================================================+
| dns_transfer		 | transfer a DNS zone                             |
+------------------------+-------------------------------------------------+
| ecs                    | list virtual machines                           |
+------------------------+-------------------------------------------------+
| ecs_create             | create and start virtual machine                |
+------------------------+-------------------------------------------------+
| ecs_delete             | delete a specific virtual machine               |
+------------------------+-------------------------------------------------+
| ecs_show               | information about a specific virtual machine    |
+------------------------+-------------------------------------------------+
| eip                    | show elastic ip-addresses                       |
+------------------------+-------------------------------------------------+
| eip_apply              | apply a new elastic ip-address                  |
+------------------------+-------------------------------------------------+
| eip_delete             | delete elastic ip-address                       |
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
| enable_snat            | enable SNAT on specific VPC                     |
+------------------------+-------------------------------------------------+
| endpoints              | discover API endpoints                          |
+------------------------+-------------------------------------------------+
| evs                    | list volumes                                    |
+------------------------+-------------------------------------------------+
| evs_create             | create a volume                                 |
+------------------------+-------------------------------------------------+
| evs_delete             | delete a volume                                 |
+------------------------+-------------------------------------------------+
| evs_show               | information about a specific volume             |
+------------------------+-------------------------------------------------+
| job                    | show job status                                 |
+------------------------+-------------------------------------------------+
| keypairs               | show ssh keypairs                               |
+------------------------+-------------------------------------------------+
| keypair_create         | create a ssh keypair                            |
+------------------------+-------------------------------------------------+
| keypair_delete         | delete a ssh keypair                            |
+------------------------+-------------------------------------------------+
| lookup_name            | lookup id by name                               |
+------------------------+-------------------------------------------------+
| os-client-config.yml   | create os-client-config yml file                |
+------------------------+-------------------------------------------------+
| ptrrecord_create       | create DNS PTR record for EIP                   |
+------------------------+-------------------------------------------------+
| ptrrecord_delete       | delete DNS PTR record for EIP                   |
+------------------------+-------------------------------------------------+
| ptrrecords             | show DNS PTR records for EIP                    |
+------------------------+-------------------------------------------------+
| rds_versions 		 | list provided database versions for RDS         |
+------------------------+-------------------------------------------------+
| rds_flavors		 | list provid flavor for selected version in RDS  |
+------------------------+-------------------------------------------------+
| services               | discover API services                           |
+------------------------+-------------------------------------------------+
| s3                     | show s3 buckets                                 |
+------------------------+-------------------------------------------------+
| s3_bucket_create       | create s3 bucket                                |
+------------------------+-------------------------------------------------+
| s3_bucket_delete       | delete s3 bucket                                |
+------------------------+-------------------------------------------------+
| s3_upload              | upload files in s3 object store                 |
+------------------------+-------------------------------------------------+
| secgroups              | show security groups                            |
+------------------------+-------------------------------------------------+
| secgroup_create        | create security group                           |
+------------------------+-------------------------------------------------+
| secgroup_delete        | delete security group                           |
+------------------------+-------------------------------------------------+
| secgrouprule_create    | create security group rule                      |
+------------------------+-------------------------------------------------+
| secgrouprule_delete    | delete security group rule                      |
+------------------------+-------------------------------------------------+
| token                  | get auth token                                  |
+------------------------+-------------------------------------------------+
| zones                  | show DNS zones                                  |
+------------------------+-------------------------------------------------+
| zonerecords            | show DNS zonerecords                            |
+------------------------+-------------------------------------------------+
| zone_create            | create DNS zone                                 |
+------------------------+-------------------------------------------------+
| zone_delete            | delete DNS zone                                 |
+------------------------+-------------------------------------------------+
| zonerecord_create      | create DNS zonerecord                           |
+------------------------+-------------------------------------------------+
| zonerecord_delete      | delete DNS zonerecord                           |
+------------------------+-------------------------------------------------+

Starting up
-----------

::

    cp secrets.yml  _secrets.yml 

  
**adjust your own data in this file before you using the examples:**

list virtual machines (with secrets.yml)::

    ansible-playbook  ecs.yml --vault-password-file vaultpass.txt

list virtual machines (with clouds.yml)::

    ansible-playbook  ecs.yml

create and start virtual machine with file injection 
(inject up to 5 max 1k base64 encoded files)::

    ansible-playbook  ecs_create.yml -e "ecs_fileinject_1=/etc/hosts ecs_fileinject_data_1=$(base64 -w 0 hosts.txt) ecs_fileinject_2=/root/README.md2 ecs_fileinject_data_2=$(base64 -w 0 hallo.txt)" --vault-password-file vaultpass.txt

create and start virtual machine with injection user_data
(inject max 32k base64 encoded user-data files)::

    ansible-playbook  ecs_create.yml -e "ecs_user_data=$(base64 -w 0 user-data.txt)" --vault-password-file vaultpass.txt

show virtual machine (single)::

    ansible-playbook  ecs_show.yml -e "ecs_name=ansible-test01"

delete virtual machine (only the machine)::

    ansible-playbook  ecs_delete.yml -e "ecs_name=ansible-test01"

delete virtual machine (delete also floating ip and attached volumes)::

    ansible-playbook  ecs_delete.yml -e "ecs_name=test01-ansible delete_publicip=1 delete_volume=1"

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

discover API endpoints::

    ansible-playbook  endpoints.yml

list volumes::

    ansible-playbook  evs.yml

create a volume (tenant.ini)::

    ansible-playbook  evs_create.yml -e "evs_name=ansible-evs01"

delete a volume ::

    ansible-playbook  evs_delete.yml -e "evs_name=ansible-evs01"

show information about a single volume::

    ansible-playbook  evs_show.yml -e "evs_name=ansible-evs01"

show elastic ip-addresses::

    ansible-playbook  eip.yml

apply a new elastic ip-address (bandwidth between 1-300 MBit/s)::

    ansible-playbook  eip_apply.yml -e "eip_bandwidth_name=ansible-eip1" -e "eip_bandwidth_size=100" -e "public_ip_address=0.0.0.0"

delete elastic ip-address::

    ansible-playbook  eip_delete.yml -e "public_ip_address=160.44.195.18"

show job status::

    ansible-playbook -e "job_id=2c9eb2c15693b00901571e32ad5e1755"  job.yml

    ./ajob 2c9eb2c15693b00901571e32ad5e1755

show keypairs::

    ansible-playbook  keypairs.yml

create keypair::

    ansible-playbook  -e "ecs_adminkey=test-key" -e "keypair_file=~/.ssh/id_rsa.pub" keypair_create.yml

delete keypair::

    ansible-playbook  -e "ecs_adminkey=test-key"  keypair_delete.yml

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

create DNS PTR record for EIP::

     ansible-playbook  ptrrecord_create.yml -e "public_ip_address=160.44.204.87" -e "ptr_name=ansible-test01.external.otc.telekomcloud.com" -e "ttl=300"

delete DNS PTR record for EIP::

     ansible-playbook  ptrrecord_delete.yml -e "public_ip_address=160.44.204.87"

show DNS PTR records for EIP::

     ansible-playbook  ptrrecords.yml

list provided database versions for RDS::

    ansible-playbook  rds_versions.yml

list provided flavors for selected database version in RDS::

     ansible-playbook  rds_flavors.yml -e "rds_version_id=286a34fc-a605-11e6-88fd-286ed488c9cb"

discover API services::

    ansible-playbook  services.yml

show s3 buckets::

    ansible-playbook  s3.yml --vault-password-file vaultpass.txt

create s3 bucket::

    ansible-playbook  -e "bucket=mybucket"  s3_bucket_create.yml  --vault-password-file vaultpass.txt

delete s3 bucket::

    ansible-playbook  -e "bucket=mybucket"  s3_bucket_delete.yml  --vault-password-file vaultpass.txt

upload files in s3 object store (VHD, ZVHD, VMDK, QCOW2 are supported for otc image service)::

    ansible-playbook  -e "bucket=mybucket" -e "object=xenial-server-cloudimg-amd64-disk1.vmdk"  s3_upload.yml  --vault-password-file vaultpass.txt

show security groups::

    ansible-playbook  secgroups.yml

show security groups (only from one vpc)::

    ansible-playbook  secgroups.yml -e "vpc_name=ansible-vpc01"

create security group (subtask in tenant_create ecs section)::

    ....

delete security group::

    ansible-playbook  secgroup_delete.yml -e "secgroup_id=6e8ac0a0-e0ec-4c4d-a786-9c9c946fd673"

create security group rule (subtask in tenant_create ecs section)::

    ...

delete security group rule::

    ansible-playbook  secgrouprule_delete.yml -e "secgrouprule_id=3c329359-fef5-402f-b29a-caac734065a1"

show DNS zones::

    ansible-playbook   zones.yml

create DNS zone (name,type and ttl are mandatory)::

    ansible-playbook  zone_create.yml -e "zone_type=public" -e "zone_name=example.com." -e "zone_description=example zone" -e "zone_email=example@example.com" -e "zone_ttl=86400" 

delete DNS zone::

    ansible-playbook  zone_delete.yml -e "zone_id=ff80808257e2bb5e0157ec5ca2620234" 

show DNS zone records::

    ansible-playbook   zonerecords.yml

create DNS zonerecord (A-Record) possible values A,AAAA,MX,CNAME,PTR,TXT,NS::

    ansible-playbook  zonerecord_create.yml -e "zone_id=ff80808257e2bb5e0157ec620968023a" -e "zonerecord_name=testserver.example.com." -e "zonerecord_type=A" -e "zonerecord_value=160.44.196.210" -e "zonerecord_ttl=86400"

create DNS zonerecord (PTR-Record)::

    see DNS PTR record section

delete DNS zonerecord ::

    ansible-playbook  zonerecord_delete.yml -e "zone_id=ff80808257e2bb5e0157ec620968023a" -e "zonerecordid=ff80808257e2bb050157ec789b5e027e" 


Full Working Example
--------------------

configure your VM in tenant.ini and run all necessary roles to bootstrap a VM::

    ansible-playbook  tenant_create.yml -e "ecs_name=ansible-test01"

This playbook will create VPC,Subnet, SecurityGroup, SSH-Keypair, allocate Floating-IP and boostrap the VM.

configure your DNS in dns.ini and deploy all zones and zonerecords::

    ansible-playbook  dns_create.yml

transfer your private dns zones to OTC using zone transfer (data stored in data.ini, needs zone transfer rights on dns_server)::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=internal.example.com" -e "zone_type=private" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"

    ansible-playbook  dns_create.yml -e "vpc_name=ansible-vpc01"

transfer your public dns zones to OTC using zone transfer::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=external.example.com" -e "zone_type=public" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"

    ansible-playbook  dns_create.yml

