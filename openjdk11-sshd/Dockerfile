FROM openjdk:11.0-jdk

MAINTAINER EDEKA DIGITAL GmbH <dpp@edeka.de>

# Relocate the timezone file
RUN echo UTC | tee /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Define the application version for the subsequent application images
ENV VERSION=1.0.0

# Define the spring boot configuration directory
ENV CONFIG_DIR=/opt/edeka/configuration

# Define the spring boot application name
ENV APP_NAME edekadigitalapp

# Define the spring boot application port
ENV APP_PORT 8000

# Define the java options
ENV JAVA_OPTS="-XX:+ExitOnOutOfMemoryError -XX:MinRAMPercentage=90 -XX:MaxRAMPercentage=90"

# Healthcheck
HEALTHCHECK CMD curl --fail http://localhost:$APP_PORT/health || exit 1

# Ports
EXPOSE $APP_PORT

### enable SSH ##
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

# Start sshd on port 33022 to be in open port range
RUN sed -i 's/#Port 22/Port 33022/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 33022

# Use wrapper script to start sshd demon
ADD wrapper.sh /wrapper.sh
RUN chmod +x /wrapper.sh
ENTRYPOINT exec /wrapper.sh
## END Enable SSH ###
