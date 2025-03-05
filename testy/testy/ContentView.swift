import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var pin: Int = 0
    @Published var isSecurePassword: Bool = true
    @Published var isLoggedIn: Bool = false
    @Published var loginFailed: Bool = false
    
    func togglePasswordVisibility() {
        isSecurePassword.toggle()
    }
    
    func login() {
        if username == "user" && password == "password" && pin == 1234 {
            isLoggedIn = true
            loginFailed = false
        } else {
            isLoggedIn = false
            loginFailed = true
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()
            
            TextField("Username", text: $viewModel.username)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if viewModel.isSecurePassword {
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                TextField("Password", text: $viewModel.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            TextField("Pin", value: $viewModel.pin, format: .number)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                viewModel.togglePasswordVisibility()
            }) {
                Text(viewModel.isSecurePassword ? "Show Password" : "Hide Password")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
            
            Button(action: {
                viewModel.login()
            }) {
                Text("Log In")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
            
            if viewModel.isLoggedIn {
                Text("Logged In!")
                    .foregroundColor(.green)
                    .font(.title3)
                    .padding(.top)
            }
            
            if viewModel.loginFailed {
                Text("Login failed")
                    .foregroundColor(.red)
                    .font(.title3)
                    .padding(.top)
            }
        }
        .padding()
    }
}
