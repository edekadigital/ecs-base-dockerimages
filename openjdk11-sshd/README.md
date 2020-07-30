# openjdk-11-ssh image

Base image with jdk and ssh daemon, use only for debugging purposes.

## How to use:
```
FROM edekadigital/ecs-base-openjdk:11-sshd

RUN echo <publickey> >> /root/.ssh/authorized_keys
```

Add the port to the port mappings in the container_definitions.json:
```
    "portMappings": [
      {
        "containerPort": 8xxx
      },
      {
        "hostPort": 33022,
        "protocol": "tcp",
        "containerPort": 33022
      }
    ],
```

After starting the task, find the ip address from the fargate console, then you can connect to port 33022 from a jump host, e.g. jenkins.

```
ssh root@10.x.x.x -p 33022
```
