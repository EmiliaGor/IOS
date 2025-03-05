from flask import Flask, jsonify, request

app = Flask(__name__)


card_data = [

		
]
@app.route('/cards', methods=['GET'])
def get_cards():
    try:
        # Return the list of cards as JSON
        return jsonify(card_data), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500  # Return error if anything goes wrong


@app.route('/card', methods=['POST'])
def add_product():
    try:
        data = request.get_json()
        
        cardNumber = data.get('cardNumber')
        expiryDate = data.get('expiryDate')
        cvv = data.get('cvv')
        nameOnCard = data.get('nameOnCard')
        new_card= {
            'id': len(card_data) + 1,
            "card_number": cardNumber,
            "expiry_date": expiryDate,
            "cvv": cvv,
            "name_on_card": nameOnCard
            # 'name': name,
            # 'price': price
        }

        card_data.append(new_card)

        return jsonify({'id': new_card['id']}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
