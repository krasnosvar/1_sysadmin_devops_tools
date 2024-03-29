#file example docker-compose.yml
version: "3.8"
#https://habr.com/ru/company/ruvds/blog/450312/
#https://docs.docker.com/compose/compose-file/
# Следует учитывать, что docker-compose работает с сервисами.
services:
  dkr27:
    image: nginx:stable
    #такой тип подключения не работает в вертии 3.0, только в 3.8
    #https://docs.docker.com/compose/compose-file/#volumes 
    volumes:
      - type: bind
        source: ./nginx.conf
        target: /etc/nginx/nginx.conf
    ports:
      - 18888:80
################################################################

#COMMANDS
docker-compose -f docker-compose-unmounted.yml up -d
docker-compose -f docker-compose-mounted.yml down


#restart only one container(service) "alertmanager" from compose
docker-compose -f /var/prometheus/docker-compose_server.yml restart alertmanager


#show running compose containers
docker-compose -f /var/prometheus/docker-compose_client.yml ps --services --filter status=running
