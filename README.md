Ansible for Open Telekom Cloud
==============================

Intro
=====

Deutsche Telekom offers since March 2016 an IaaS Service named
Open Telekom Cloud (OTC). The service includes
* Virtual Private Cloud (VPC)
* Elastic Cloud Server (ECS)
* Elastic Load Balancer (ELB)
* Elastic Volume Service (EVS)
* Image Management Service (IMS)
* Object Storage Service (OBS)
* Dynamic Name Service (DNS)
* Relational Database Service (RDS)
and other useful things. The portfolio will rapidly developed.


Content
=======
Here are some roles to demonstrate how to interact with OTC-API.
ECS-API is origin developed by Huawei and described here:
http://support.hwclouds.com/en-us/api/ecs/en-us_topic_0020805967.html

Roles
=====
|role         | description|
|-------------|------------|
|dns_transfer		| transfer a DNS zone |
|ecs                    | list virtual machines|
|ecs_create             | create and start virtual machine|
|ecs_delete             | delete a specific virtual machine|
|ecs_show               | information about a specific virtual machine|
|eip                    | show elastic ip-addresses|
|eip_apply              | apply a new elastic ip-address|
|eip_delete             | delete elastic ip-address|
|elb                    | list elastic loadbalancers|
|elb_create             | create elastic loadbalancer|
|elb_delete             | delete elastic loadbalancer|
|elb_show               | show elastic loadbalancer|
|elb_certificate        | show elastic loadbalancer certificates|
|elb_certificate_create | create elastic loadbalancer certificate|
|elb_certificate_delete | delete elastic loadbalancer certificate|
|elb_healthcheck_create | create elastic loadbalancer healthcheck|
|elb_healthcheck_delete | delete elastic loadbalancer healthcheck|
|elb_healthcheck_show   | show elastic loadbalancer healthcheck|
|elb_listener           | list listener for elastic loadbalancer|
|elb_listener_create    | create listener for elastic loadbalancer|
|elb_listener_delete    | delete listener from elastic loadbalancer|
|elb_backends           | list backends for elastic loadbalancer|
|elb_backends_create    | create backends for elastic loadbalancer|
|elb_backends_delete    | delete backends for elastic loadbalancer|
|enable_snat            | enable SNAT on specific VPC|
|endpoints              | discover API endpoints|
|evs                    | list volumes|
|evs_create             | create a volume|
|evs_delete             | delete a volume|
|evs_show               | information about a specific volume|
|flavors                | show flavors|
|images                 | show images|
|image_create           | create an image |
|image_delete           | delete an image |
|job                    | show job status|
|keypairs               | show ssh keypairs|
|keypair_create         | create a ssh keypair|
|keypair_delete         | delete a ssh keypair|
|lookup_name            | lookup id by name (set_fact image_id, vpc_id, subnet_id, secgroup_id, flavor_id)|
|os-client-config.yml   | create os-client-config yml file|
|ptrrecord_create       | create DNS PTR record for EIP|
|ptrrecord_delete       | delete DNS PTR record for EIP|
|ptrrecords             | show DNS PTR records for EIP|
|rds_versions		| list provided database versions for RDS|
|rds_flavors		| list provided flavors for selected database version in RDS|
|services               | discover API services|
|s3                     | show s3 buckets|
|s3_bucket_create       | create s3 bucket|
|s3_bucket_delete       | delete s3 bucket|
|s3_upload              | upload files in s3 object store|
|secgroups              | show security groups|
|secgroup_create        | create security group|
|secgroup_delete        | delete security group|
|secgrouprule_create    | create security group rule|
|secgrouprule_delete    | delete security group rule|
|subnet                 | show subnet|
|subnet_create          | create subnet|
|subnet_delete          | delete subnet|
|token                  | get auth token|
|vpc                    | show vpc|
|vpc_router             | show vpc router info and set facts|
|vpc_create             | create vpc|
|vpc_delete             | delete vpc|
|zones                  | show DNS zones|
|zonerecords            | show DNS zonerecords|
|zone_create            | create DNS zone|
|zone_delete            | delete DNS zone|
|zonerecord_create      | create DNS zonerecord|
|zonerecord_delete      | delete DNS zonerecord|

Requirements
============
* curl
* openssl
* base64
* ansible==2.2.0.0
* python-jmespath
* python-netaddr


  *Ubuntu 14.04/16.04:*
  
  ```
     apt-get install software-properties-common
     apt-get update
     apt-cache policy ansible
     apt-get install curl python-pip python-jmespath python-netaddr
     pip install ansible==2.2.0.0
  ```
  
  *OpenSuSE 13.2:*
  
  ```
     zypper ar http://download.opensuse.org/repositories/systemsmanagement/openSUSE_13.2/systemsmanagement.repo
     zypper up
     zypper install curl ansible python-jmespath python-netaddr
  ```    
      
(should work on all other *nix systems, check the right version of ansible!!!)

* :exclamation: credentials on OTC (username, password, domain, S3 access/secret key)

Files outside the repo
======================
| filename                      | description|
|-------------------------------|------------|
|~/.config/openstack/clouds.yml | os-client configuration file for multiple openstack environments|

Files
=====
| filename       | description|
|----------------|------------|
|ajob            | shell script to fetch job status from OTC|
|env.yml         | profile to use in clouds.yml|
|secrets.yml     | var file for S3 credentials and endpoints (ansible-vault)|
|vaultpass.txt   | password file for ansible-vault. The default password is: linux :-)|
|hosts           | host file for ansible (we use only localhost)|
|tenant.ini      | configuration file for tenant|
|dns.ini         | configuration file for dns|


os-client config
================

for more comfort and standardization we moved credential lookup from secrets.yml to clouds.yml (part of https://docs.openstack.org/developer/os-client-config/). If you already configured your OTC credentials there put your profile name in env.yml or use
```
    ansible-playbook -e "CLOUD=otc" ...
```
if your profile named otc

If you like to start with this feature run once os-client-config.yml and answer the question. A basic yml file with one
profile will created for you:

```
ansible-playbook  os-client-config.yml
```


Starting up
===========

```
    cp secrets.yml  _secrets.yml 
```
  
:exclamation: **adjust your own data in this file before you using the examples:**

list virtual machines (with secrets.yml)

    ansible-playbook -i hosts ecs.yml --vault-password-file vaultpass.txt

list virtual machines (with clouds.yml)

    ansible-playbook -i hosts ecs.yml

create and start virtual machine with file injection 
(inject up to 5 max 1k base64 encoded files)

    ansible-playbook -i hosts ecs_create.yml -e "ecs_fileinject_1=/etc/hosts ecs_fileinject_data_1=$(base64 -w 0 hosts.txt) ecs_fileinject_2=/root/README.md2 ecs_fileinject_data_2=$(base64 -w 0 hallo.txt)" --vault-password-file vaultpass.txt

create and start virtual machine with injection user_data
(inject max 32k base64 encoded user-data files)

    ansible-playbook -i hosts ecs_create.yml -e "ecs_user_data=$(base64 -w 0 user-data.txt)" --vault-password-file vaultpass.txt

show virtual machine (single)

    ansible-playbook -i hosts ecs_show.yml -e "ecs_name=ansible-test01"

delete virtual machine (only the machine)

    ansible-playbook -i hosts ecs_delete.yml -e "ecs_name=ansible-test01"

delete virtual machine (delete also floating ip and attached volumes)

    ansible-playbook -i hosts ecs_delete.yml -e "ecs_name=test01-ansible delete_publicip=1 delete_volume=1"

list elastic loadbalancers

    ansible-playbook -i hosts elb.yml

create elastic loadbalancer (tenant.ini)

    ansible-playbook -i hosts elb_create.yml -e "elb_name=ansible-elb01"

delete elastic loadbalancer

    ansible-playbook -i hosts elb_delete.yml -e "elb_name=ansible-elb01"

show elastic loadbalancer

    ansible-playbook -i hosts elb_show.yml -e "elb_name=ansible-elb01"

list elastic loadbalancer certificates

    ansible-playbook -i hosts elb_certificate.yml 

create elastic loadbalancer certificate (we hate comments in cert file)

    ansible-playbook -i hosts elb_certificate_create.yml -e "elb_certificate_name=ansible-cert elb_certificate_key_file=cert.key elb_certificate_certificate_file=cert.crt" 

delete elastic loadbalancer certificates

    ansible-playbook -i hosts elb_certificate_delete.yml -e "listener_certificate_name=ansible-cert"

create elastic loadbalancer healthcheck (tenant.ini)

    ansible-playbook -i hosts elb_healthcheck_create.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01"

delete elastic loadbalancer healthcheck

    ansible-playbook -i hosts elb_healthcheck_delete.yml -e "elb_healthcheck_id=e12454b93f304b759be699cb0270648c"

show elastic loadbalancer healthcheck

    ansible-playbook -i hosts elb_healthcheck_show.yml -e "elb_healthcheck_id=e12454b93f304b759be699cb0270648c"

list listener for elastic loadbalancer

    ansible-playbook -i hosts elb_listener.yml -e "elb_name=ansible-elb01"

create listener for elastic loadbalancer (tenant.ini)

    ansible-playbook -i hosts elb_listener_create.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01"

delete listener for elastic loadbalancer

    ansible-playbook -i hosts elb_listener_delete.yml -e "elb_name=ansible-elb01"  -e "listener_name=ansible-listener03"

list backends for elastic loadbalancer (tenant.ini)

    ansible-playbook -i hosts elb_backends.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" 

create backends for elastic loadbalancer

    ansible-playbook -i hosts elb_backends_create.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" -e "ecs_name=ansible-test01" -e "ecs_address=192.168.0.10"

delete backends for elastic loadbalancer

    ansible-playbook -i hosts elb_backends_delete.yml -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01" -e "elb_backends_id=d15e2f8dd7d64d95a6b5c2a791cac408"

enable SNAT on specific VPC

    ansible-playbook -i hosts snat_enable.yml -e "vpc_name=ansible-vpc1" -e "enable_snat=true"

disable SNAT on specific VPC

    ansible-playbook -i hosts snat_enable.yml -e "vpc_name=ansible-vpc1" -e "enable_snat=false"

discover API endpoints

    ansible-playbook -i hosts endpoints.yml

list volumes

    ansible-playbook -i hosts evs.yml

create a volume (tenant.ini)

    ansible-playbook -i hosts evs_create.yml -e "evs_name=ansible-evs01"

delete a volume 

    ansible-playbook -i hosts evs_delete.yml -e "evs_name=ansible-evs01"

show information about a single volume

    ansible-playbook -i hosts evs_show.yml -e "evs_name=ansible-evs01"

show flavors

    ansible-playbook -i hosts flavors.yml

show elastic ip-addresses

    ansible-playbook -i hosts eip.yml

apply a new elastic ip-address (bandwidth between 1-300 MBit/s)

    ansible-playbook -i hosts eip_apply.yml -e "eip_bandwidth_name=ansible-eip1" -e "eip_bandwidth_size=100" -e "public_ip_address=0.0.0.0"

delete elastic ip-address

    ansible-playbook -i hosts eip_delete.yml -e "public_ip_address=160.44.195.18"

show images

    ansible-playbook -i hosts images.yml

create image (from stopped ecs instance)

    ansible-playbook -i hosts image_create.yml -e "image_name=ansible-image01" -e "ecs_name=ansible-test01"

create image (from obs image_url <bucket>:<file>)

    ansible-playbook -i hosts image_create.yml -e "image_name=ansible-image02" -e "image_url=ansible1:/xenial-server-cloudimg-amd64-disk1.vmdk" -e "image_min_disk=12"

delete an image (API return code is 204 when success, ansible expected 200 and may give an error)

     ansible-playbook -i hosts -e "image_id=af0a0bcf-7be3-4722-98ba-3350801a8cd5" image_delete.yml

show job status

    ansible-playbook -e "job_id=2c9eb2c15693b00901571e32ad5e1755" -i hosts job.yml

    ./ajob 2c9eb2c15693b00901571e32ad5e1755

show keypairs

    ansible-playbook -i hosts keypairs.yml

create keypair

    ansible-playbook -i hosts -e "ecs_adminkey=test-key" -e "keypair_file=~/.ssh/id_rsa.pub" keypair_create.yml

delete keypair

    ansible-playbook -i hosts -e "ecs_adminkey=test-key"  keypair_delete.yml

lookup id by name (image)

    ansible-playbook -i hosts lookup_name.yml -e "image_name=Community_Ubuntu_16.04_TSI_latest"

lookup id by name (flavor)

    ansible-playbook -i hosts lookup_name.yml -e "ecs_ram=2048" -e "ecs_vcpus=4"

lookup id by name (subnet)

    ansible-playbook -i hosts lookup_name.yml -e "subnet_name=subnet-5831"

lookup id by name (secgroup)

     ansible-playbook -i hosts lookup_name.yml -e "secgroup_name=bitnami-wordpress-56a9-securitygroup"

lookup id by name (vpc)

     ansible-playbook -i hosts lookup_name.yml -e "vpc_name=vpc-4988"

lookup id by name (eip)

     ansible-playbook -i hosts lookup_name.yml -e "public_ip_address=160.44.1.1"
  
lookup id by name (zone)

     ansible-playbook -i hosts lookup_name.yml -e "zone_name=example.com."

lookup id by name (ecs)

     ansible-playbook -i hosts lookup_name.yml -e "ecs_name=ansible-test01"

lookup id by name (evs)

     ansible-playbook -i hosts lookup_name.yml -e "evs_name=ansible-evs01"

lookup id by name (elb)

     ansible-playbook -i hosts lookup_name.yml -e "elb_name=ansible-elb01"

lookup id by name (certificate)

     ansible-playbook -i hosts lookup_name.yml  -e "listener_certificate_name=ansible-cert"

lookup id by name (listener)

     ansible-playbook -i hosts lookup_name.yml  -e "listener_name=ansible-listener01" -e "elb_name=ansible-elb01"

create DNS PTR record for EIP

     ansible-playbook -i hosts ptrrecord_create.yml -e "public_ip_address=160.44.204.87" -e "ptr_name=ansible-test01.external.otc.telekomcloud.com" -e "ttl=300"

delete DNS PTR record for EIP

     ansible-playbook -i hosts ptrrecord_delete.yml -e "public_ip_address=160.44.204.87"

show DNS PTR records for EIP

     ansible-playbook -i hosts ptrrecords.yml

list provided database versions for RDS

    ansible-playbook -i hosts rds_versions.yml

list provided flavors for selected database version in RDS

     ansible-playbook -i hosts rds_flavors.yml -e "rds_version_id=286a34fc-a605-11e6-88fd-286ed488c9cb"

discover API services

    ansible-playbook -i hosts services.yml

show s3 buckets

    ansible-playbook -i hosts s3.yml --vault-password-file vaultpass.txt

create s3 bucket

    ansible-playbook -i hosts -e "bucket=mybucket"  s3_bucket_create.yml  --vault-password-file vaultpass.txt

delete s3 bucket

    ansible-playbook -i hosts -e "bucket=mybucket"  s3_bucket_delete.yml  --vault-password-file vaultpass.txt

upload files in s3 object store (VHD, ZVHD, VMDK, QCOW2 are supported for otc image service)

    ansible-playbook -i hosts -e "bucket=mybucket" -e "object=xenial-server-cloudimg-amd64-disk1.vmdk"  s3_upload.yml  --vault-password-file vaultpass.txt

show security groups

    ansible-playbook -i hosts secgroups.yml

show security groups (only from one vpc)

    ansible-playbook -i hosts secgroups.yml -e "vpc_name=ansible-vpc01"

create security group (subtask in tenant_create ecs section)

    ....

delete security group

    ansible-playbook -i hosts secgroup_delete.yml -e "secgroup_id=6e8ac0a0-e0ec-4c4d-a786-9c9c946fd673"

create security group rule (subtask in tenant_create ecs section)

    ...

delete security group rule

    ansible-playbook -i hosts secgrouprule_delete.yml -e "secgrouprule_id=3c329359-fef5-402f-b29a-caac734065a1"

show subnets

    ansible-playbook -i hosts subnet.yml

create subnet (subtask in tenant_create ecs section)

    ...

delete subnet

    ansible-playbook -i hosts subnet_delete.yml -e "vpc_name=ansible-vpc01" -e "subnet_name=ansible-subnet01"

show vpc

    ansible-playbook -i hosts vpc.yml

show vpc router info and set facts

    ansible-playbook -i hosts vpc_router.yml -e "vpc_name=ansible-vpc01"

create vpc

    ansible-playbook -i hosts vpc_create.yml -e "vpc_name=ansible-vpc1" -e "vpc_net=192.168.0.0/16"

delete vpc

    ansible-playbook -i hosts vpc_delete.yml -e "vpc_name=ansible-vpc01"

show DNS zones

    ansible-playbook -i hosts  zones.yml

create DNS zone (name,type and ttl are mandatory)

    ansible-playbook -i hosts zone_create.yml -e "zone_type=public" -e "zone_name=example.com." -e "zone_description=example zone" -e "zone_email=example@example.com" -e "zone_ttl=86400" 

delete DNS zone

    ansible-playbook -i hosts zone_delete.yml -e "zone_id=ff80808257e2bb5e0157ec5ca2620234" 

show DNS zone records

    ansible-playbook -i hosts  zonerecords.yml

create DNS zonerecord (A-Record) possible values A,AAAA,MX,CNAME,PTR,TXT,NS

    ansible-playbook -i hosts zonerecord_create.yml -e "zone_id=ff80808257e2bb5e0157ec620968023a" -e "zonerecord_name=testserver.example.com." -e "zonerecord_type=A" -e "zonerecord_value=160.44.196.210" -e "zonerecord_ttl=86400"

create DNS zonerecord (PTR-Record)

    see DNS PTR record section

delete DNS zonerecord 

    ansible-playbook -i hosts zonerecord_delete.yml -e "zone_id=ff80808257e2bb5e0157ec620968023a" -e "zonerecordid=ff80808257e2bb050157ec789b5e027e" 


Full Working Example
--------------------

configure your VM in tenant.ini and run all necessary roles to bootstrap a VM

    ansible-playbook -i hosts tenant_create.yml -e "ecs_name=ansible-test01"

This playbook will create VPC,Subnet, SecurityGroup, SSH-Keypair, allocate Floating-IP and boostrap the VM.

configure your DNS in dns.ini and deploy all zones and zonerecords

    ansible-playbook -i hosts dns_create.yml

transfer your private dns zones to OTC using zone transfer (data stored in data.ini, needs zone transfer rights on dns_server)

    ansible-playbook dns_transfer.yml  -e "dns_server=127.0.0.1" -e "zone_name=internal.example.com" -e "zone_type=private" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"

    ansible-playbook -i hosts dns_create.yml -e "vpc_name=ansible-vpc01"

transfer your private dns zones to OTC using zone transfer

    ansible-playbook dns_transfer.yml  -e "dns_server=127.0.0.1" -e "zone_name=external.example.com" -e "zone_type=public" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"


Contributing
------------
Very welcome. We are in a very early state of automated platform deployment
on OTC. So each help is still welcome

1. Fork it.
2. Create a branch (`git checkout -b my_markup`)
3. Commit your changes (`git commit -am "Added Snarkdown"`)
4. Push to the branch (`git push origin my_markup`)
5. Open a [Pull Request][1]
6. Enjoy a refreshing Diet Coke and wait

