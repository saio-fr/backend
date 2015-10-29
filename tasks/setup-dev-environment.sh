#!/bin/env bash

# pull images
gcloud docker pull eu.gcr.io/saio-fr/crossbar:master
gcloud docker pull eu.gcr.io/saio-fr/authenticator:master
gcloud docker pull eu.gcr.io/saio-fr/authorizer:master
gcloud docker pull eu.gcr.io/saio-fr/customer:master
gcloud docker pull eu.gcr.io/saio-fr/user:master

# start services
echo "starting database...";
docker run -d -P \
	--name backend-db \
	memsql/quickstart;
sleep 20;

echo "creating databases...";
# docker exec doest not work in circle ci.
# docker exec -d customer-db memsql-shell -e \
# "create database customer;";
docker run --rm \
	--name backend-mysql-client \
	--link backend-db:db \
	mysql sh -c \
	'mysql -h "$DB_PORT_3306_TCP_ADDR" -u root \
	--execute="create database customer;
		create database user;
		create database authorizer"';
sleep 20;

echo "starting crossbar...";
docker run -d -p 8080:8080 -p 8081:8081 \
  --name backend-crossbar \
  eu.gcr.io/saio-fr/crossbar:master;
sleep 20;

echo "starting authenticator service...";
docker run -d \
  --name backend-authenticator \
  --link backend-crossbar:crossbar \
  eu.gcr.io/saio-fr/authenticator:master;
sleep 4;

echo "starting authorizer service...";
docker run -d \
  --name backend-authorizer \
  --link backend-db:db \
  --link backend-crossbar:crossbar \
  eu.gcr.io/saio-fr/authorizer:master;
sleep 20;

echo "starting customer service...";
docker run -d \
  --name backend-customer \
  --link backend-db:db \
  --link backend-crossbar:crossbar \
  eu.gcr.io/saio-fr/customer:master;
sleep 20;

echo "starting user service...";
docker run -d \
  --name backend-user \
  --link backend-db:db \
  --link backend-crossbar:crossbar \
  eu.gcr.io/saio-fr/user:master;
sleep 20;

# Final task: add some data in our database
echo "add some data to db";
docker run --rm \
	--name backend-mysql-client \
	--volume `pwd`/tasks/import.sql:/var/lib/mysql/import.sql \
	--link backend-db:db \
	mysql sh -c \
	'mysql -h "$DB_PORT_3306_TCP_ADDR" -u root \
	--execute="source /var/lib/mysql/import.sql"';
sleep 20;
