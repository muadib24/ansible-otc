otc_rds (WIP)
=============

OTC role for RDS.

Variables:
^^^^^^^^^^

+-------------------------+-----------------------------------------------------------+
| Name                    | Description                                               |
+=========================+===========================================================+
| rds_version_id          | ID of the RDS version (to use to fetch flavor             |
+-------------------------+-----------------------------------------------------------+


Functions:
^^^^^^^^^^

Version::

    ansible-playbook rds.yml -e "localaction=version"

Flavor::

    ansible-playbook rds.yml -e "localaction=flavor" -e "rds_version_id=fb6d2f7d-b431-41ec-a73f-b6bead3e73f0"
