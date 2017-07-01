Build your own images with ansible (WiP)

1. Download Ubuntu Cloud Image
2. Upload to IMS (private, generic name)
3. Boot VM with this image
4. Login ssh, install, configure, doing things
5. Shutdown VM
6. Upload VM image to IMS (private, customize name)

requirements: ** adjust buildservice_var.yml **


usage:

``` 
ansible-playbook  -i hosts buildservice.yml -e "distro=trusty" --vault-password-file vaultpass.txt

ansible-playbook  -i hosts buildservice.yml -e "distro=xenial" --vault-password-file vaultpass.txt
```

