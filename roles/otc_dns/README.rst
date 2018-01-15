otc_dns
============

OTC role for DNS. This role creates zones, zone records and reverse
entries (PTR records).

Variables:
^^^^^^^^^^

+-------------------------+---------------------------------------------+
| Name                    | Description                                 |
+=========================+=============================================+
| zone_name               | name of DNS zone                            |
+-------------------------+---------------------------------------------+
| zone_id                 | id of DNS zone                              |
+-------------------------+---------------------------------------------+
| zone_description        | Description of DNS zone                     |
+-------------------------+---------------------------------------------+
| zone_type               | DNS zone type (public/private)              |
+-------------------------+---------------------------------------------+
| zone_email              | Email address of SOA                        |
+-------------------------+---------------------------------------------+
| zone_ttl                | DNS zone TTL in sec                         |
+-------------------------+---------------------------------------------+
| zone_records            | List of zone records                        |
+-------------------------+---------------------------------------------+
| ptr_name                | FQDN for PTR record                         |
+-------------------------+---------------------------------------------+


Functions:
^^^^^^^^^^

create::

    ansible-playbook tenant_yml.yml -e "zone_name=ansible.otc.telekomcloud99.com" -e "localaction=create"

    ansible-playbook tenant_ini.yml -e "zone_name=ansible.internal.corp" -e "vpc_name=ansible-vpc01" -e "localaction=create"


ptrcreate::

    ansible-playbook tenant_yml.yml -e "zone_name=ansible.otc.telekomcloud99.com" -e "ecs_name=ansible-test01" -e "localaction=ptr_create"


show::

    ansible-playbook tenant_yml.yml -e "zone_name=ansible.otc.telekomcloud99.com" -e "localaction=show"

    ansible-playbook tenant_ini.yml -e "zone_name=ansible.internal.corp" -e "vpc_name=ansible-vpc01" -e "localaction=show"


list::

    ansible-playbook tenant_yml.yml -e "zone_name=ansible.otc.telekomcloud99.com" -e "localaction=list"

    ansible-playbook tenant_ini.yml -e "zone_name=ansible.internal.corp" -e "vpc_name=ansible-vpc01" -e "localaction=list"


delete::

    ansible-playbook tenant_yml.yml -e "zone_name=ansible.otc.telekomcloud99.com" -e "localaction=delete"

    ansible-playbook tenant_ini.yml -e "zone_name=ansible.internal.corp" -e "vpc_name=ansible-vpc01" -e "localaction=delete"

