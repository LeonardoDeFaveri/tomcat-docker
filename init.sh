#!/bin/env bash

/opt/tomcat/latest/bin/catalina.sh start
service ssh start

## Run a shell so we don't exit
/bin/bash
