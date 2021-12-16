#!/bin/bash

#Establish db
cmd=$1
db_username=OwenSLiu
db_password=centos1234

#Establish Docker
sudo systemctl status docker || sudo systemctl start docker

#Check Container Status
docker container inspect jrvs-psql
container_status=$?

#Use Case Cmd to create several if cases for docker creation judging by container status checker above
case $cmd in
  create)

  # Check if the container is already created
  if [ $container_status -eq 0 ]; then
    echo 'Container already exists'
    exit 1
  fi

  #check the number of CLI arguments
  if [ $# -ne 3 ]; then
    echo 'Create requires username and password'
    exit 1
  fi

  #Create Container with Docker
  #Retrieve postgres image
  docker pull postgres

  #create a volume for backup
  docker volume create pgdata

  #Set password for postgres
  export PGPASSWORD='password'

  #Create a container with psql image: Name: jrvs-psql
  docker run --name jrvs-psql -e POSTGRES_PASSWORD=$PGPASSWORD -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
  exit $?
  ;;

  start|stop)
  # check instance's status; exit 1 if container has not been created
  if [ $container_status -eq 1 ]; then
    echo "container has not been created"
    exit 1

  #Start or stop the container
  docker container $cmd jrvs-psql
  exit $?
  fi
  ;;

  *)
  echo 'illegal command'
  echo 'Commands:start|stop|create'
  exit 1
  ;;
esac



