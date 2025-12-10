# services/todo.py
from flask import Flask, jsonify
import os, json

app = Flask(__name__)
DB_PATH = os.path.join(os.path.dirname(__file__), '..', 'database', 'todo.json')

def load_todos():
    try:
        with open(DB_PATH, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception:
        return []

@app.route('/todos', methods=['GET'])
def todos():
    return jsonify(load_todos())

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5003))
    app.run(host='0.0.0.0', port=port)


