#https://access.redhat.com/documentation/en-us/red_hat_satellite/6.4/html/content_management_guide/creating_an_application_life_cycle
#REPOSITORIES COMMANDS
#create new repo
hammer repository create \
--name "Epel-centOS-8" \
--content-type "yum" \
--publish-via-http true \
--url https://dl.fedoraproject.org/pub/epel/8/Everything/x86_64/ \
--gpg-key "CentOS_8_gpg_key" \
--product "CentOS_8_via_repo" \
--organization "Org_name" \
--ignore-global-proxy "true" \
--verify-ssl-on-sync "false" \
--download-policy "on_demand"  \
--mirror-on-sync "false"

#sync repo to fetch packets
hammer repository synchronize \
--product "CentOS_8_via_repo" \
--name "Epel-centOS-8" \
--organization "Org_name" \
--async

#CAPSULES COMMANDS
hammer capsule list
hammer capsule info --id 3
#
hammer capsule content available-lifecycle-environments \
--id 3
#
hammer capsule content add-lifecycle-environment \
--id capsule_id --organization "My_Organization" \
--environment-id environment_id
