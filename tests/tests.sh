#!/bin/sh

cd tests
# test flavor list
ansible-playbook test.yml -e "localaction=flavor"

# test ecs list
ansible-playbook test.yml -e "localaction=list"
