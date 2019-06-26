# Dockerized Projector 8.0.5 with LDAP support
This repo contains a docker-compose.yml that allow to run Projeqtor V8.0.5 with a Postgres and PgAdmin.

## Build and run with docker-compose 

To run Projeqtor + postgres + pgadmin :

- Edit a `.env` file where you downloaded the docker-compose file like the one on this repo

- Run the command

```
docker-compose up -d --build
```

Here are possible (useless ?) build args 

```
--build-arg PROJEQTOR_LOG_PATH=/var/log/projeqtor
--build-arg PROJEQTOR_CONFIG_PATH=/etc/projeqtor
```

## Docker-compose
Here is what is run when using docker-compose
- Projeqtor : 
    - http://127.0.0.1:8080
    - Service name : projeqtor
- Postgres : 
    - http://127.0.0.1:5432
    - Service name : db
- PgAdmin : 
    - http://127.0.0.1:6543
    - Service name : pgadmin

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
https://hub.docker.com/r/mawsfr/projeqtor

## Questions and Suggestions
Feel free to open issues to ask questions or make suggestions ;)

## Projeqtor configuration example
![projeqtor config example](img/projeqtor.png?raw=true "Configuration example")
