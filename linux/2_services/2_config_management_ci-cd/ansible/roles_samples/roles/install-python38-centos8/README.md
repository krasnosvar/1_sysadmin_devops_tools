# Ansible-Python-CentOS

##### Роль для установки питон-3.8 на CentOS-8 
*форкнута с:*
* https://github.com/narbutas/ansible-python37-centos7


This role is or installing Python from source code on CentOS machines.
After installation there will be python{{python_ver_var}} exported and you can check if everything works fine bycommands:
```
python{{python_ver_var}} -V
pip{{python_ver_var}} -v
```

Available variables:
```
python_version_default (as default set to 3.7.3)        # Python version to be installed
python_ver_var        (as default set to python3.7)     # Python version number without minor release number to set python pats
```

Default playbook:
```
---
- name: Python installation
  hosts: all
  become: true
  vars:
    python_version_default: 3.7.3
  roles:
    role: "ansible-python37-centos7"
---
```

### How to contribute
If you want to help improve this role please clone it and create pull request with your code.
