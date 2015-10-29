#!/bin/env bash

# stop
docker stop backend-authorizer;
docker stop backend-authenticator;
docker stop backend-user;
docker stop backend-customer;
docker stop backend-crossbar;
docker stop backend-db;
docker stop backend-mysql-client;
docker stop backend-service;

# clean
docker rm backend-authorizer;
docker rm backend-authenticator;
docker rm backend-customer;
docker rm backend-user;
docker rm backend-crossbar;
docker rm backend-db;
docker rm backend-mysql-client;
docker rm backend-service;

# uninstall
docker rmi backend-authenticator;
docker rmi backend-authorizer;
docker rmi backend-customer;
docker rmi backend-user;
docker rmi backend-crossbar;
docker rmi backend-db;
docker rmi backend-mysql-client;
docker rmi backend-service;
