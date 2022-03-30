# Tomcat image for Docker

This Ubuntu based image includes a Tomcat server and an emacs instance with pratical configurations.

## Versions
Ubuntu: `latest`
Tomcat: `9.0.60`
emacs: `26`
java-jdk: `openjdk-11`
maven: `3.6.3`

## Details
Tomcat
 - base directory: `/opt/tomcat/latest`
 - config directory: `/opt/tomcat/latest/conf`
 - catalina.sh: `/opt/tomcat/latest/bin`
 - deployed webapps: `/opt/tomcat/latest/webapps`

## Developement
Webapps should be placed into `/data` and then deployed into deployed webapps directory of Tomcat.
To do so use mvn package and then copy `target/${artifactID}-1.0-Snapshot` into tomcat webapps directory.
Change folder name to change webapp address.

## Interacting with the container
### Directly on container with root privileges
You can just attach to the cointainer
```
docker attach tomcat
```

### Via ssh
It is possible to connect to the container via ssh on user remote with default password remote.

You can use the following command to connect to the container and start a bash shell in it

```
ssh remote@${containerIP} -t "/bin/bash"
```

To get the container IP use one of the following

For newer docker engines:
```
docker inspect -f "{{ .NetworkSettings.IPAddress }}" tomcat
```

For older:
```
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' tomcat
```
