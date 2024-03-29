
# https://devconnected.com/how-to-search-ldap-using-ldapsearch-examples/

#install ldapsearch
# ubuntu
sudo apt install -y ldap-utils
# centos
# openldap – This packages contains the LDAP support libraries
# openldap-servers – This is the main LDAP server
# openldap-clients – This contains all required LDAP client utilities
yum install -y openldap openldap-clients openldap-servers
# or
yum install openldap*


#проверить наличие у этого пользователя аттрибутов
ldapsearch -h adldap.corp.domain.ru -LLL -D "admin_user@corp.domain.ru" -W -b "dc=corp,dc=domain,dc=ru" -s sub "(cn=user)" loginShell unixHomeDirectory
#вывод с LDAP группами
ldapsearch -h adldap.corp.domain.ru -LLL -D "admin_user@corp.domain.ru" -W -b "dc=corp,dc=domain,dc=ru" -s sub "(cn=user)" loginShell unixHomeDirectory memberOf
#проверить наличие у этого сервера аттрибутов
ldapsearch -h adldap.corp.domain.ru -LLL -D "admin_user@corp.domain.ru" -W -b "dc=corp,dc=domain,dc=ru" -s sub "(cn=V00SOLVOORA-TST)" userAccountControl sAMAccountName dNSHostName userPrincipalName servicePrincipalName
