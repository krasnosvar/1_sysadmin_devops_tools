#sudo ansible-playbook -i test-role/hosts  test-role/test-role.yml --extra-vars='ansible_ssh_pass=local-password  ansible_become_pass=local-password

# path to file in playbook(no need to write all path to file, use variable "role_path")
# "{{ role_path }}/templates/keepalived.conf.j2"

# ansible loop for hostname(in template, for example)
# writes string with "facts": server "hostname" "ip-address":443 check
# {% for backend in groups['test'] %}
# server {{ ansible_hostname }} {{ ansible_ens192['ipv4']['address'] }}:443 check
# {% endfor %}

#check ssh connection
ansible all -u den -i inventory/inventory.cfg -m ping

#create role sample
ansible-galaxy init test-role


#execute task in playbook only in "fetch" group
    - name: Execute  command
      hosts: fetch
      shell: "whoami"
      when: inventory_hostname in groups['fetch']
 
