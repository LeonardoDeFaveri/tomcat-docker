#!/bin/env bash

/opt/tomcat/latest/bin/catalina.sh start > /dev/null
service ssh start > /dev/null

## Run a shell so we don't exit
/bin/bash
