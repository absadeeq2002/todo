

from flask import Flask, jsonify, request

app = Flask(__name__)

USERS = [
    {"id": 1, "name": "John Doe"},
    {"id": 2, "name": "Aisha Bello"}
]

@app.get("/users")
def get_users():
    return jsonify(USERS)

@app.post("/users")
def create_user():
    data = request.json
    new_user = {
        "id": len(USERS) + 1,
        "name": data.get("name")
    }
    USERS.append(new_user)
    return jsonify(new_user), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5002)
