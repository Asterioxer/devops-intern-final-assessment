# DevOps Intern Final Assessment

[![Python CI](https://github.com/Asterioxer/devops-intern-final-assessment/actions/workflows/ci.yml/badge.svg)](https://github.com/Asterioxer/devops-intern-final-assessment/actions/workflows/ci.yml)

**Name:** Soham Mukherjee  
**Date:** 09 January 2026  

---

## Overview

This repository demonstrates a **complete and intentionally designed DevOps pipeline** using open-source tools.  
The goal of the project is not just execution, but **correct reasoning about automation, orchestration, and observability**.

The system is built around a **batch-style workload**, chosen deliberately to reflect proper lifecycle management in schedulers such as Nomad.

---

## Tech Stack

- Linux (Bash scripting)
- Git & GitHub
- Docker
- GitHub Actions (CI/CD)
- HashiCorp Nomad (batch orchestration)
- Grafana Loki (log aggregation)
- Grafana (log visualization)

---

## Repository Structure

.
├── hello.py
├── Dockerfile
├── scripts/
│ └── system_info.sh
├── tests/
│ └── test_hello.py
├── .github/workflows/
│ └── ci.yml
├── nomad/
│ └── hello.nomad
└── monitoring/
├── loki_setup.txt
├── promtail-config.yml
└── hello-devops-logs-dashboard.json


---

## 1. Application Design (`hello.py`)

The application is a **batch-style Python program**:

- Performs a finite task
- Emits timestamped logs
- Exits explicitly with success (`0`) or failure (`1`)

This design allows:
- CI pipelines to detect failures
- Nomad to reason about job completion
- Logging systems to capture meaningful output

Run locally:
```bash
python hello.py
```

## 2. Linux Scripting (scripts/system_info.sh)

A diagnostic Bash script written in strict mode to fail fast.

Collected information:

Current user and hostname

Disk usage

Memory usage

Run:
```bash
chmod +x scripts/system_info.sh
./scripts/system_info.sh
```

This type of script is commonly used in CI runners and infrastructure debugging.

## 3. Containerization (Docker)

The application is packaged as a single-responsibility batch container.

Key design decisions:

Minimal Python base image

Non-root execution for security

ENTRYPOINT executes the application directly

Container lifecycle matches application lifecycle

Build:
```bash
docker build -t hello-devops:1.0.0 .
```

Run:
```bash
docker run --rm hello-devops:1.0.0
```

## 4. CI/CD with GitHub Actions

The CI pipeline enforces real quality gates, not just execution.

Included checks:

Static analysis using flake8

Unit testing using pytest

The workflow runs on every push and pull request to prevent regressions.

Workflow file:

.github/workflows/ci.yml

## 5. Batch Orchestration with Nomad

The workload is deployed using HashiCorp Nomad as a batch job.

Why batch?

The application performs a finite task and exits

Restarting on success would be incorrect

Logs are the primary signal, not uptime

Key characteristics:

type = "batch"

Restarts disabled to avoid masking failures

Explicit CPU and memory allocation

Log retention configured

Run Nomad in dev mode:

```bash
sudo nomad agent -dev
```

Submit the job:

nomad job run nomad/hello.nomad

## 6. Monitoring & Observability (Grafana Loki)
Log Flow
Application stdout
→ Docker logging driver
→ Loki
→ Grafana

Platform Consideration

On Docker Desktop (Windows / WSL2), container log files are not directly accessible for filesystem scraping.
To demonstrate real log ingestion, Docker’s Loki logging driver is used to push logs directly to Loki.

Example:
```bash
docker run --rm \
  --log-driver=loki \
  --log-opt loki-url=http://host.docker.internal:3100/loki/api/v1/push \
  hello-devops:1.0.0
```

Visualization

A Grafana dashboard is included to visualize logs using LogQL queries.

This confirms:

Logs are ingested into Loki

Logs are queryable and inspectable

Observability flow is correctly understood

