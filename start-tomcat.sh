#!/bin/env bash

docker run --detach -ti -p 8080:8080 --name tomcat \
	-v /media/leonardo/various/esercizi-uni/prog-web/data:/root/data \
	--network=tomcat-docker_xampp-tomcat \
	my/tomcat
