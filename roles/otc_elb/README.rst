otc_ecs
=======

OTC role for Elastic Load Balancer (ELB).

Variables:
^^^^^^^^^^

+------------------------------------+---------------------------------------------------------------+
| Name                               | Description                                                   |
+====================================+===============================================================+
| localaction="list"                 | List ELB                                                      |
+------------------------------------+---------------------------------------------------------------+
| localaction="show"                 | Show ELB resources                                            |
+------------------------------------+---------------------------------------------------------------+
| localaction="create"               | Create ELB                                                    |
+------------------------------------+---------------------------------------------------------------+
| localaction="elblistenercreate"    | Create ELB Listener                                           |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbhealthcheckcreate" | Create ELB Healthcheck                                        |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbcertificatecreate" | Create ELB Certificate                                        |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbbackendcreate"     | Create ELB Backend                                            |
+------------------------------------+---------------------------------------------------------------+
| localaction="delete"               | Delete ELB                                                    |
+------------------------------------+---------------------------------------------------------------+
| localaction="elblistenerdelete"    | Delete ELB Listener                                           |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbhealthcheckdelete" | Delete ELB Healthcheck                                        |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbcertificatedelete" | Delete ELB certificate                                        |
+------------------------------------+---------------------------------------------------------------+
| localaction="elbbackenddelete"     | Delete ELB Backend                                            |
+------------------------------------+---------------------------------------------------------------+
| elb_name                           | name of ELB                                                   |
+------------------------------------+---------------------------------------------------------------+
| elb_id                             | id of ELB                                                     |
+------------------------------------+---------------------------------------------------------------+
| admin_state_up                     | state of the ELB                                              |
+------------------------------------+---------------------------------------------------------------+
| elb_availability_zone              | Availability zone where ELB is located                        |
+------------------------------------+---------------------------------------------------------------+
| elb_bandwidth                      | Bandwidth of the ELB                                          |
+------------------------------------+---------------------------------------------------------------+
| elb_type                           | Typ of ELB (internal or external                              |
+------------------------------------+---------------------------------------------------------------+
| elb_secgroup_name                  | Security Group bound on ELB                                   |
+------------------------------------+---------------------------------------------------------------+
| elb_subnet_name                    | Subnet of ELB                                                 |
+------------------------------------+---------------------------------------------------------------+
| elb_vpc_name                       | VPC of ELB                                                    |
+------------------------------------+---------------------------------------------------------------+
| listener_protocol                  | Listener protocol (HTTP, HTTPS, TCP)                          |
+------------------------------------+---------------------------------------------------------------+
| listener_port                      | Listener Port                                                 |
+------------------------------------+---------------------------------------------------------------+
| listener_backend_protocol          | Listener Backend Protocol (HTTP, HTTPS, TCP)                  |
+------------------------------------+---------------------------------------------------------------+
| listener_backend_port              | Listener Backend Port                                         |
+------------------------------------+---------------------------------------------------------------+
| listener_lb_algorithm              | Listener Algorithm (source,  roundrobin, leastconn)           |
+------------------------------------+---------------------------------------------------------------+
| listener_certificate_name          | Listener SSL Certificate Name                                 |
+------------------------------------+---------------------------------------------------------------+
| listener_tcp_timeout               | Listener TCP timeout                                          |
+------------------------------------+---------------------------------------------------------------+
| listener_cookie_timeout            | Listener Timeout for Cookies                                  |
+------------------------------------+---------------------------------------------------------------+
| listener_sticky_session_type       | Listener Sticky Session Type (insert if Cookie used)          |
+------------------------------------+---------------------------------------------------------------+
| listener_session_sticky            | Listener Session Sticky (true or false)                       |
+------------------------------------+---------------------------------------------------------------+
| healthcheck_connect_port           | Connect Port for the health check                             |
+------------------------------------+---------------------------------------------------------------+
| healthcheck_interval               | Interval for the health check                                 |
+------------------------------------+---------------------------------------------------------------+
| healthcheck_protocol               | Protocol for the health check                                 |
+------------------------------------+---------------------------------------------------------------+
| healthcheck_timeout                | Timeout for the health check                                  |
+------------------------------------+---------------------------------------------------------------+
| healthcheck_uri                    | URI for the health check (HTTP/HTTPS)                         |
+------------------------------------+---------------------------------------------------------------+
| unhealthy_threshold                | Treshold for unhealthy state                                  |
+------------------------------------+---------------------------------------------------------------+
| backend_members                    | Backend member for the ELB Listener                           |
+------------------------------------+---------------------------------------------------------------+

Functions:
^^^^^^^^^^

Create::

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "localaction=create"

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elblistenercreate"

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elbhealthcheckcreate"
    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elbbackendcreate"


Show::

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "localaction=show"

List::

    ansible-playbook tenant_yml.yml -e "localaction=delete"

Delete::

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "localaction=delete"

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elblistenerdelete"

    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elbhealthcheckdelete"
    ansible-playbook tenant_yml.yml -e "elb_name=ansible-elb01" -e "listener_name=ansible-listener01" -e "localaction=elbbackenddelete"
