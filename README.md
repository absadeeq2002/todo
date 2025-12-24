# **To-Do Application**
### How to Run the example

1. Get the codebase in your development machine by executing `git clone https://github.com/h4xr/todo todo`
2. Now, get into the todo directory that was created due to the above step by executing `cd <path_to_directory>`
3. The next step is to setup a virtual environment for the project since it will help us in keeping our dependencies isolated from the rest of the system. To create virtual environment, we can execute the following command `virtualenv venv`. This will create a virtual environment named *venv* inside the project folder.
4. The next step is to activate the virtual environment. For this, execute, `source venv/bin/activate`
5. Next, we need to get the required dependencies in our system for running the example. The dependencies are listed inside *requirements.txt*. The pip tool can help you setup the required dependencies for the same. Execute the following command to setup the dependencies: `pip install -r requirements.txt`
6. At this point of time, we have all the required dependencies setup in the system. Its time to run our microservices. It can be achieved by executing `python run.py`
7. You can verify whether the services are running properly or not by visiting `http://localhost:5000`
This project includes automation scripts to simplify building, running, monitoring, and cleaning up the application environment.

Available Scripts
Script	Description
start.ps1 / start.sh	Builds and starts all services using Docker Compose
cleanup.ps1 / cleanup.sh	Stops containers and removes unused Docker resources
monitor.sh	Displays running containers and resource usage
scan.sh	Performs container security scanning
## 🚀 DevSecOps Automation Overview

This project implements a complete DevSecOps automation pipeline for a Dockerized microservices-based TODO application.  
The automation improves **maintainability**, **security**, and **deployment reliability**.

---

## 🛠️ Automation Components

### 1️⃣ Automated Build and Startup
- Bash (`start.sh`) and PowerShell (`start.ps1`) scripts automate:
  - Building Docker images
  - Starting all services using Docker Compose
  - Optional rebuild and log streaming
- Eliminates manual Docker commands and reduces human error.

**Example commands:**
```bash
./scripts/start.sh --rebuild
./scripts/start.sh --logs
# Secure Containerized TODO Application (DevSecOps Project)

## 📌 Project Overview
This project demonstrates how to securely containerize, deploy, and automate a microservices-based TODO application using DevSecOps best practices.

The application consists of multiple Python microservices and an NGINX frontend, all orchestrated using Docker Compose and secured at build-time and runtime.

---

## 🧱 Architecture
**Services Included:**
- Frontend (NGINX)
- Auth Service
- Users Service
- Todos Service
- Log Processor Service

Each service runs in its own container and communicates via an isolated Docker bridge network.

---

## 🔐 Part 4: Secrets Management

### ✔ Removed Hardcoded Secrets
- No credentials or tokens are hardcoded in source code.
- All sensitive values are injected at runtime.

### ✔ Secure Secret Storage
- Secrets are stored using `.env` files.
- `.env` file is excluded from version control using `.gitignore`.

### ✔ Secure Injection
Secrets are injected using Docker Compose environment variables:
```yaml
env_file:
  - .env
## 🔐 Secrets Management
- Secrets are stored in a `.env` file (not committed to GitHub)
- Injected into containers using Docker Compose environment variables
- Secrets are inaccessible from the host or other containers

## 🛡️ Container Runtime Security
- All Linux capabilities dropped (`cap_drop: ALL`)
- Containers run with read-only filesystems
- Privilege escalation disabled (`no-new-privileges`)
- Network access restricted to internal Docker network
- Unauthorized access attempts are blocked and verified

