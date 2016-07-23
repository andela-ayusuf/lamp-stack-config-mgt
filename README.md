# LAMP-STACK-CONFIG-MGT
- This Ansible playbook sets up a LAMP(Linux, Apache, MySql and PHP) stack environment on an Ubuntu 14.04.4 LTS Virtual Machine(VM).
- It is also a prerequisite for installing **Nagios Core** monitoring tool on your VM.


**Requirements**

- Before running this Ansible playbook, you must have Ansible installed locally. You can find out about how to install Ansible [here](http://docs.ansible.com/ansible/intro_installation.html).
- The private key to the VM which is to be configured is also a requirement.


**Clone This Project**
```
git clone https://github.com/andela-ayusuf/lamp-stack-config-mgt.git
```

**Variables**

You will need to update the variables files i.e. **vars.yml** and **vars.rb** files with the appropriate variables. Currently there are only dummy variables in the variable files and these will not work. The **inventory.ini** file also has to be updated with the public IP address of the VM which is about to be configured.


**Running The Project**

From your terminal, cd into this project directory:

```
$ cd lamp-stack-config-mgt
```
Run the playbook:
```
$ ansible-playbook playbook.lamp.yml -i inventory.ini --private-key=path/to/private/key
```
With that done you have a LAMP stack configured on our VM. If you will like to go on and install Nagios Core monitoring tool, there is a playbook [here](https://github.com/andela-ayusuf/nagios-ansible) to do just that.

**Issues**

If you happen to run into any problems while using this playbook or you would like to make contributions to it, please endeavour to open an issue [here](https://github.com/andela-ayusuf/nagios-ansible-remote/issues).

Best regards :)