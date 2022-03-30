#!/bin/env bash

docker run --detach -ti -p 8080:8080 -p 22:22 --name tomcat \
	-v /media/leonardo/various/esercizi-uni/prog-web/data:/data \
	--network=tomcat-docker_xampp-tomcat -e LANG=C.UTF-8 \
	my/tomcat
