import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String = ""
    @State private var showAlert: Bool = false  // New state for handling the alert
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            // Username text field
            TextField("Username", text: $username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .autocapitalization(.none)
                .padding(.bottom, 20)
            
            // Password text field
            SecureField("Password", text: $password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)

            // Error message (if any)
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            // Login Button
            Button(action: {
                login()
            }) {
                Text("Login")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(isLoggedIn ? "Success" : "Error"),
                  message: Text(isLoggedIn ? "You have logged in successfully!" : errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
    
    let API = "http://127.0.0.1:5000"
    
    func login() {
        let serverURL = API + "/login"
        
        // URL configuration
        guard let url = URL(string: serverURL) else {
            errorMessage = "Invalid URL"
            showAlert = true
            return
        }
        
        let request = URLRequest(url: url)
        
        // Session with default configuration
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
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
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] {
                    // Loop through the response and check for a valid user
                    DispatchQueue.main.async {
                        if (json.first(where: { $0["login"] as? String == self.username && $0["password"] as? String == self.password }) != nil) {
                            self.isLoggedIn = true
                            self.errorMessage = ""
                        } else {
                            self.isLoggedIn = false
                            self.errorMessage = "Invalid username or password"
                        }
                        self.showAlert = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Invalid JSON format"
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
