from flask import Flask, jsonify, request

app = Flask(__name__)

categories_data = [
    {
        'id': 1,
        'nazwa': 'warzywa',
    },
    {
        'id': 2,
        'nazwa': 'owoce',
    }
]

products_data = [
    {'id': 1, 'nazwa': 'Ziemniak', 'cena': 2},
    {'id': 2, 'nazwa': 'Cebula', 'cena': 1.5},
    {'id': 3, 'nazwa': 'Gruszka', 'cena': 1},
    {'id': 4, 'nazwa': 'banan', 'cena': 3},
		
]


@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories_data)

@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products_data)


if __name__ == '__main__':
    app.run(debug=True)
