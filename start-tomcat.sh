#!/bin/env bash

data_dir="Your dir"

docker run --detach -ti -p 8080:8080 -p 22:22 --name tomcat \
	-v ${data_dir}:/data \
	--network=tomcat-docker_xampp-tomcat -e LANG=C.UTF-8 \
	my/tomcat
