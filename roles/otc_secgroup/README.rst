otc_secgroup
============

OTC role for security groups. This role creates security groups defined
for an ECS and creates the rules. The rules are defined in an extra section.
Standard rules will be removed before the defined rules are created.

Variables:
^^^^^^^^^^

+-------------------------+---------------------------------------------+
| Name                    | Description                                 |
+=========================+=============================================+
| secgroup_name           | name of Secgroup                            |
+-------------------------+---------------------------------------------+
| secgroup_id             | id of Secgroup                              |
+-------------------------+---------------------------------------------+
| secgroups               | list of secgroups in ecs section            |
+-------------------------+---------------------------------------------+
| secgrouprules           | list of rules for a security group          |
+-------------------------+---------------------------------------------+
| secgrouprule_id         | id of a secgroup rule                       |
+-------------------------+---------------------------------------------+

Functions:
^^^^^^^^^^

Create::

    ++

Show::

    ++

List::

    ++

Delete::

    ++
