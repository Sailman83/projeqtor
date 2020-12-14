# Dockerized Projector with PHP 7.4.13
This repo contains a docker-compose.yml that allow to run Projeqtor

## Docker-compose

Here is what is run when using docker-compose
- Projeqtor : 
    - http://127.0.0.1:8080/
    - Service name : projeqtor

## Run from docker-hub
If you already have a running postgres instance, just run Projeqtor by executing the command
```bash
docker run -d \
    --net <POSTGRES_NETWORK> \
    --link <POSTGRES_CONTAINER_NAME>:db \
    -p 8080:80 \
    --name projeqtor805 \
mawsfr/projeqtor:latest
```

## Docker Hub
https://hub.docker.com/r/sailman83/projeqtor

## Projeqtor configuration example
- Database type : mysql
- Database host: 'non du container DB'
- Database user to connect :
- Database password for user :
- Database schema name :
- ...
- Directory to store Attachments : /attachment
- Temp directory for reports : /report
- Log file name : /log/projeqtor_${date}.log
- Parameter file name : /parameter/parameters.php

Fork from MawsFr/projeqtor
