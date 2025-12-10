from flask import Flask, request, jsonify
import json
import os

app = Flask(__name__)

DATA_FILE = "database/users.json"

# Load users from file
def load_users():
    try:
        with open(DATA_FILE, "r") as f:
            return json.load(f)
    except:
        return []

# Save users to file
def save_users(users):
    with open(DATA_FILE, "w") as f:
        json.dump(users, f, indent=4)

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    users = load_users()

    username = data.get("username")
    password = data.get("password")

    for user in users:
        if user["username"] == username and user["password"] == password:
            return jsonify({"message": "Login successful", "user": user}), 200

    return jsonify({"message": "Invalid username or password"}), 401

@app.route("/register", methods=["POST"])
def register():
    data = request.json
    users = load_users()

    new_user = {
        "id": len(users) + 1,
        "username": data.get("username"),
        "password": data.get("password")
    }

    users.append(new_user)
    save_users(users)

    return jsonify({"message": "User registered", "user": new_user}), 201

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5001))
    app.run(host="0.0.0.0", port=port)
