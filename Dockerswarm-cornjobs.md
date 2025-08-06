# Docker Swarm Cronjobs Research Document

## 📘 Introduction

Docker Swarm is Docker's native clustering and orchestration tool, which enables the deployment and management of containers in a clustered environment. While Docker Swarm is powerful for service orchestration, it lacks native support for scheduled tasks like Kubernetes' CronJobs. This document explores how to implement cron-like jobs in Docker Swarm.

---

## ⏰ Cronjob Options in Docker Swarm

### 1. **Using Host's Cron with Docker Commands**

You can use the host system's `cron` daemon to schedule jobs that run Docker commands like `docker service update --force` to trigger tasks periodically.

```bash
# Example: Run service update every day at 2 AM
0 2 * * * docker service update --force strapi-service
```

### 2. **Scheduled Jobs with CI/CD Tools**

Tools like GitHub Actions, Jenkins, or GitLab CI/CD can be scheduled to run workflows that deploy or trigger services.

```yaml
on:
  schedule:
    - cron: '0 2 * * *'
```

### 3. **Using Third-party Tools**

* **cron2docker**: A simple Go-based utility to trigger containers based on cron syntax.
* **Swarmcron**: Automatically generates Swarm services based on crontab definitions.
* **Kapacitor**: Useful in TICK stack environments for scheduled jobs.

---

## 🛠️ Example Setup: Cron Triggered Docker Service

### Step 1: Create a service in Swarm

```bash
docker service create \
  --name cron-echo \
  --replicas 1 \
  alpine:latest \
  /bin/sh -c 'while true; do echo Hello from $(hostname); sleep 60; done'
```

### Step 2: Add cron job on the host

```bash
crontab -e
```

```cron
*/5 * * * * docker service update --force cron-echo
```

### Step 3: Validate Logs

```bash
docker service logs cron-echo
```

---

## 📸 Screenshots

### 1. Docker Service List

![Service List](img/service-ls.png)

### 2. Cron Schedule Output

![Crontab](img/crontab.png)

### 3. Logs of Cron Trigger

![Logs](img/logs.png)

---

## 📊 Benefits & Limitations

### ✅ Benefits:

* Easy to integrate with existing Docker infrastructure
* No extra orchestration overhead

### ❌ Limitations:

* Depends on host machine's availability
* No built-in error recovery or job tracking
* Limited monitoring options without external tools

---

## 🧾 Conclusion

While Docker Swarm lacks native cron job support, it is feasible to simulate cron jobs through external systems such as the host cron, CI/CD pipelines, or third-party tools. With careful setup, you can integrate scheduled job execution seamlessly in a Swarm environment.

---

## 🔗 References

* [Docker Swarm Docs](https://docs.docker.com/engine/swarm/)
* [cron2docker](https://github.com/cfstras/cron2docker)
* [Swarmcron](https://github.com/containrrr/swarm-cronjob)
* [GitHub Actions Schedule](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule)

---

**Author:** Harika Baddam
**Task:** Task 13 – Docker Swarm Cronjobs Research
