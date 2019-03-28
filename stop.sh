#/bin/bash
docker service rm myservice_php-fpm 
docker service rm myservice_redis-db 
docker service rm myservice_nginx
docker service rm myservice_mysql-db
