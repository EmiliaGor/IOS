import SwiftUI

let API = "http://127.0.0.1:5000"

struct ContentView: View {
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var nameOnCard = ""
    @State private var errorMessage = ""
    @State private var showAlert = false
    @State private var paymentSuccess = false
    
    var body: some View {
        VStack {
            Text("Enter Credit Card Details")
                .font(.largeTitle)
                .padding()
            
            // Card Number TextField
            TextField("Card Number", text: $cardNumber)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Expiry Date TextField
            TextField("MM/YY", text: $expiryDate)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // CVV TextField
            TextField("CVV", text: $cvv)
                .keyboardType(.numberPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Name on Card TextField
            TextField("Name on Card", text: $nameOnCard)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            // Submit Button
            Button(action: {
                processPayment()
            }) {
                Text("Pay Now")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            // Payment Status
            if paymentSuccess {
                Text("Payment Successful!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            } else if showAlert {
                Text(errorMessage)
                    .font(.title)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
    
    func processPayment() {
        let serverURL = API + "/card" // Flask server's /card endpoint
        
        // Prepare the JSON payload with credit card information
        let paymentDetails: [String: Any] = [
            "cardNumber": cardNumber,
            "expiryDate": expiryDate,
            "cvv": cvv,
            "nameOnCard": nameOnCard
        ]
        
        guard let url = URL(string: serverURL) else {
            errorMessage = "Invalid URL"
            showAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Convert the payment details into JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: paymentDetails, options: [])
            request.httpBody = jsonData
        } catch {
            errorMessage = "Failed to encode payment details"
            showAlert = true
            return
        }
        
        // Send the request
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                    self.showAlert = true
                }
                return
            }
            
            // Debugging: Print raw data to check response
            if let rawResponse = String(data: data, encoding: .utf8) {
                print("Raw response from server: \(rawResponse)")
            }
            
            do {
                // Try to parse the JSON response
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        if let cardID = json["id"] as? Int {
                            self.paymentSuccess = true
                            self.errorMessage = "Payment processed successfully with card ID: \(cardID)"
                        } else {
                            self.paymentSuccess = false
                            self.errorMessage = "Payment failed"
                        }
                        self.showAlert = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Invalid JSON response"
                        self.showAlert = true
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to parse response"
                    self.showAlert = true
                }
            }
        }
        
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
