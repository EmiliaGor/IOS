from flask import Flask, jsonify, request

app = Flask(__name__)

login_data = [
    {
        'login': 'user',
        'password': 'password',
    }
]




@app.route('/login', methods=['GET'])
def get_categories():
    return jsonify(login_data)


if __name__ == '__main__':
    app.run(debug=True)
