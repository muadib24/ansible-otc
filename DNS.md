# OTC DNS - the complete example

DNS services are provided by OTC since months. Now the complete stack
is reworked so we can take a closer look on API service.

![OTC Dashboard](/pictures/otc-dns.png)

The service is located on the dashboard in the network services area.
There are 3 main features as you can see on the screen:

* Public Zones
* Private Zones
* PTR-Records

Private Zones and PTR-Records are completly new. If you have older 
implementation with setup reverse zones, please update to the new one.
A good thing: it's simple!

![OTC API](/pictures/otc-dns-api.png)

Documentation can you found at https://docs.otc.t-systems.com/en-us/dns_dld/index.html

Let's start to implement some DNS entries via API. We will do this with Ansible.

First of all we need connection to OTC. Use the [Connect Cheat Sheet](https://github.com/eumel8/ansible-otc/blob/poc_dns_v2/CONNECT.md)

It's a good idea to install openstack-client because ansible will use
the same os-client-config. 

```
git clone -b poc_dns_v2 https://github.com/eumel8/ansible-otc.git
cd ansible-otc
cp secrets.yml  _secrets.yml 
```
In _secrets.yml are only S3 credentials stored. You need to adjust *env.yml* 
with the used profile name in clouds.yml. Ignore the *_secrets.yml* settings

```
# adjust account data here or in clouds.yml
USERNAME: "<username>"
PASSWORD: "<password>"
DOMAIN: "OTC-EU-DE-0000000000100000XXXX"
PROJECT_NAME: "eu-de"

EC2_ACCESS_KEY: "<obs access key>"
EC2_SECRET_KEY: "<obs secret key>"
EC2_URL: "https://obs.otc.t-systems.com"

# endpoint urls
IAM_AUTH_URL: "https://iam.{{ PROJECT_NAME }}.otc.t-systems.com/v3"
AUTH_URL_ELB: "https://elb.{{ PROJECT_NAME }}.otc.t-systems.com/v1.0"
AUTH_URL_ECS_CLOUD: "https://ecs.{{ PROJECT_NAME }}.otc.t-systems.com/v1"
AUTH_URL_RDS: "https://rds.{{ PROJECT_NAME }}.otc.t-systems.com/rds/v1"
```

Service endpoint for DNS is provided by IAM, so it's not necessary to setup.


Imagine we have a dns.ini with the configuration of all resources of DNS:

![dns.ini](/pictures/tenant-ini-dns.png)

Formely the sections dnszones snd dnszonerecords were in tenant.ini file

**Public** zones are isolated on OTC. You can host your zones there but there 
is no registration service to catch new domains. This means you need to 
delegate your elsewhere registered domains to the public OTC server:

**ns1.open-telekom-cloud.com** and **ns2.open-telekom-cloud.com**

Before you need to configure your zone in OTC (see below) because the domain 
(and all sub-domain) are uniq bound to one tenant. If someone else has 
configured the domain, you need the service desk to clarify.

**Private zones** are only reachable in the selected VPC and with the resolver host **100.125.4.25**

**Reverse DNS** (PTR records) are only provided for public ip (EIP). The
ip address must assigned to your tenant to set the PTR record.

Related playbooks are *zone_create.yml*, *zonerecord_create.yml* and *ptrrecord_create.yml*


Lets start a virtual machine with a fixed private ip address and an allocated EIP:

```
ansible-playbook -i hosts tenant_create.yml -e "ecs_name=ansible-test101"
```

In this play we allocate all resources to bootstrap our ECS instance, set the floating ip
address and the reverse DNS

```
ansible-playbook -i hosts dns_create.yml -e "vpc_name=ansible-vpc01"
```

Here we create zones and zonerecords. API works asynchron so if job processing is slow
you need to repeat the step if the zone is not ready when zonerecords are added.

Tests:
```
$ host -t A  ansible-test101.ansible.otc.telekomcloud2.com ns1.open-telekom-cloud.com
Using domain server:
Name: ns1.open-telekom-cloud.com
Address: 46.29.103.61#53
Aliases: 

ansible-test101.ansible.otc.telekomcloud2.com has address 160.44.207.211

$ host -t A 160.44.207.211  ns1.open-telekom-cloud.com
Using domain server:
Name: ns1.open-telekom-cloud.com
Address: 46.29.103.61#53
Aliases: 

211.207.44.160.in-addr.arpa domain name pointer ansible-test101.ansible.otc.telekomcloud2.com.

$ host  ansible-test101.ansible.internal.corp 100.125.4.25
Using domain server:
Name: 100.125.4.25
Address: 100.125.4.25#53
Aliases: 

ansible-test101.ansible.internal.corp has address 192.168.0.101

```

Remove DNS reverse entry:

```
ansible-playbook -i hosts ptrrecord_delete.yml -e "public_ip_address=160.44.207.211"
```

Migrate your complete zones automatically

Private zone:

```
ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=internal.example.com" -e "zone_type=private" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"
ansible-playbook -i hosts dns_create.yml -e "vpc_name=ansible-vpc01"
```

Public zone:

```
ansible-playbook dns_transfer.yml  -e "dns_server=127.0.0.1" -e "zone_name=external.example.com" -e "zone_type=public" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"
ansible-playbook -i hosts dns_create.yml
```


End of PoC. Look at the [other plays and roles](https://github.com/eumel8/ansible-otc) to interact with OTC API

