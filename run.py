
import subprocess
import time
import json
import os

# ================================
# CONFIGURATION
# ================================

CONFIG_FILE = "dependencies.ini"

def load_config():
    """
    Load service configuration from dependencies.ini
    """
    if not os.path.exists(CONFIG_FILE):
        print(f"[ERROR] Config file {CONFIG_FILE} not found.")
        return {}

    config = {}
    with open(CONFIG_FILE, "r") as f:
        for line in f.readlines():
            if "=" in line:
                key, value = line.strip().split("=")
                config[key] = value
    return config


def check_service_running(port):
    """
    Check if a service is running by checking the port.
    """
    try:
        result = subprocess.run(
            ["lsof", "-i", f":{port}"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        return result.returncode == 0
    except FileNotFoundError:
        print("[WARNING] lsof not found in container. Port scan skipped.")
        return False


def start_service(service_name, host, port):
    """
    Start a service with Python.
    """
    print(f"[INFO] Starting service '{service_name}' at http://{host}:{port}")

    try:
        subprocess.Popen(
            ["python", f"services/{service_name}/app.py"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        time.sleep(2)
    except Exception as e:
        print(f"[ERROR] Failed to start {service_name}: {e}")


def main():
    config = load_config()

    if not config:
        print("[ERROR] No config loaded. Exiting...")
        return

    # Example:
    # service_auth=localhost:5001
    # service_todos=localhost:5002

    for key, value in config.items():
        service_name = key.replace("service_", "")
        host, port = value.split(":")

        print(f"[CHECK] Checking service '{service_name}' on port {port}...")

        if check_service_running(port):
            print(f"[OK] {service_name} is already running.")
        else:
            print(f"[WARN] {service_name} not running. Starting...")
            start_service(service_name, host, port)

    print("[DONE] All services checked.")


if __name__ == "__main__":
    print("[START] Boot manager running...")
    main()
