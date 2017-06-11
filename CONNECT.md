# OTC Connect Sheet Cheat

How to connect to the Open Telekom Cloud
----------------------------------------

Install prerequisites as root on your Ubuntu 16.04 machine:


```
add-apt-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install curl git ansible python-openstackclient python-pip python-jmespath python-netaddr libs3-2 jq
pip install python-otcclient
```

Follow instruction as normal user. You need always username, password, domain data.


# 1. Openstack-Client

```
mkdir -p ~/.config/openstack
touch ~/.config/openstack
chmod 600 ~/.config/openstack
vi ~/.config/openstack/clouds.yml
```

clouds.yml:
```
clouds:
    otc.10000:
        auth:
            auth_url: https://iam.eu-de.otc.t-systems.com:443/v3
            username: xxxxxx
            password: xxxxxx
            project_name: eu-de
            project_domain_name: Default
            user_domain_name: OTC-EU-DE-00000000001000010000
        region_name: eu-de
    otc.19720:
        auth:
            auth_url: https://iam.eu-de.otc.t-systems.com:443/v3
            username: xxxxx
            password: xxxxx
            project_name: eu-de
            project_domain_name: Default
            user_domain_name: OTC-EU-DE-00000000001000019720
        region_name: eu-de

```

For multiple mandants you can use different chapter. At least you need per chapter username, password,user_domain_name.
Region is limited to eu-de but can also adjust to other regions

Test connection

```
openstack --os-cloud otc.19720 server list
```

# 2. Python OTC-Client

```
mkdir -p ~/.otc
touch ~/.otc/config
chmod 600 ~/.otc/config
vi ~/.otc/config
```

config:

```
[otc]
# otc_access_key_id = yyyyy
# otc_secret_access_key = yyyyy
username = xxxxx
apikey = xxxxx
domain = OTC-EU-DE-00000000001000019720
```

otc_access_key_id/otc_secret_access_key are not necessary. *apikey* means password

Test connection

```
otc ecs describe_instances
```

# 3. Bash OTC-Tools

```
git clone https://github.com/OpenTelekomCloud/otc-tools.git
touch ~/.otc_env.sh
chmod 600 ~/.otc_env.sh
vi ~/.otc_env.sh
```

Variables are set in shell env or in .otc_env.sh

```
OS_USERNAME=xxxxx
OS_PASSWORD=xxxxx
OS_USER_DOMAIN_NAME=OTC-EU-DE-00000000001000019720
OS_PROJECT_NAME=eu-de
OS_AUTH_URL=https://iam.eu-de.otc.t-systems.com/v3
```

Test connection

```
cd otc-tools
./otc.sh ecs list
```

# 4. Ansible for Open Telekom Cloud

```
git clone https://github.com/eumel8/ansible-otc.git
cd openstack-ansible
cp secrets.yml  _secrets.yml 
cp ecs_secrets.yml  _ecs_secrets.yml 
cp elb_secrets.yml _elb_secrets.yml
ansible-vault edit _secrets.yml --vault-password-file vaultpass.txt
```

Adjust these lines

```
USERNAME: "xxxxx"
PASSWORD: "xxxxx"
DOMAIN: "xxxxx"
```

Test connection

```
ansible-playbook -i hosts ecs.yml --vault-password-file vaultpass.txt
```

