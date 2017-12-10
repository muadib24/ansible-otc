Ansible for Open Telekom Cloud
==============================

[![Documentation Status](https://readthedocs.org/projects/ansible-otc/badge/?version=latest)](http://ansible-otc.readthedocs.io/en/dev/?badge=latest)
[![Build Status](https://travis-ci.org/eumel8/ansible-otc.svg?branch=dev)](https://travis-ci.org/eumel8/ansible-otc)

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

Full documentation is using Sphinx and is now hosted on http://ansible-otc.readthedocs.io/en/latest/

For local build use:

```
    tox -edocs
    pip install -r requirements.txt
```

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

