Roles for lab (in evaluation/dev)
---------------------------------

+------------------------+-------------------------------------------------+
| role                   | description                                     |
+========================+=================================================+
| dns_transfer		 | transfer a DNS zone                             |
+------------------------+-------------------------------------------------+
| os-client-config.yml   | create os-client-config yml file                |
+------------------------+-------------------------------------------------+
| rds_versions 		 | list provided database versions for RDS         |
+------------------------+-------------------------------------------------+
| rds_flavors		 | list provid flavor for selected version in RDS  |
+------------------------+-------------------------------------------------+

Starting up
-----------

::

    cp secrets.yml  _secrets.yml 

  
**adjust your own data in this file before you using the examples:**


transfer your private dns zones to OTC using zone transfer (data stored in data.ini, needs zone transfer rights on dns_server)::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=internal.example.com" -e "zone_type=private" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"

transfer your public dns zones to OTC using zone transfer::

    ansible-playbook dns_transfer.yml -e "dns_server=127.0.0.1" -e "zone_name=external.example.com" -e "zone_type=public" -e "zone_email=nobody@localhost" -e "zone_ttl=86400"
