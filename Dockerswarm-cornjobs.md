# Docker Swarm Cronjobs

## Introduction
Explanation of Docker Swarm and why cronjobs are needed.

## Options to Schedule Cronjobs
- Option 1: Host OS crontab using `docker service`
- Option 2: Use a dedicated container like `crazy-max/swarm-cronjob`
- Option 3: Build your own Cron manager with Bash + Docker SDK

## Example Using crazy-max/swarm-cronjob
```yaml
version: "3.8"
services:
  cronjob:
    image: crazymax/swarm-cronjob
    ...
