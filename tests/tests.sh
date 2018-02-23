#!/bin/sh

cd tests

# test otc_ims: show image 
ansible-playbook test.yml -e "image_name=Community_Ubuntu_16.04_TSI_latest" -e "localaction=show"
# test otc_ecs: show flavors
ansible-playbook test.yml -e "localaction=flavors"
# test ecs list
# ansible-playbook test.yml -e "localaction=list"
# e2e test
# ansible-playbook create_test.yml -e "ecs_name=travis-test01"
# ansible-playbook delete_test.yml -e "ecs_name=travis-test01"
