#!/bin/sh

cd tests
# test flavor list
ansible-playbook test.yml -e "localaction=flavor"

# test ecs list
ansible-playbook test.yml -e "localaction=list"

# e2e test
# ansible-playbook create_test.yml -e "ecs_name=travis-test01"
# ansible-playbook delete_test.yml -e "ecs_name=travis-test01"
