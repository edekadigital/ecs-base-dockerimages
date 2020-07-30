#!/bin/bash

/usr/sbin/sshd

java $JAVA_OPTS -jar /app.jar
