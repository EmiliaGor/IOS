import XCTest
@testable import testy

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.username, "")
        XCTAssertEqual(viewModel.password, "")
        XCTAssertEqual(viewModel.pin, 0)
        XCTAssertTrue(viewModel.isSecurePassword)
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertFalse(viewModel.loginFailed)
        
    }
    
    func testLoginWithValidCredentials() {
        viewModel.username = "user"
        viewModel.password = "password"
        viewModel.pin = 1234
        
        viewModel.login()
        
        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertFalse(viewModel.loginFailed)
    }
    
    func testLoginWithInvalidCredentials() {
        viewModel.username = "user"
        viewModel.password = "wrongpassword"
        viewModel.pin = 1234
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginWithInvalidCredentials2() {
        viewModel.username = "user"
        viewModel.password = "password"
        viewModel.pin = 4321
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginWithInvalidCredentials3() {
        viewModel.username = "wronguser"
        viewModel.password = "password"
        viewModel.pin = 1234
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginWithInvalidCredentials4() {
        viewModel.username = "wronguser"
        viewModel.password = "wrongpassword"
        viewModel.pin = 1234
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginWithInvalidCredentials5() {
        viewModel.username = "wronguser"
        viewModel.password = "wrongpassword"
        viewModel.pin = 4321
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testTogglePasswordVisibility() {
        XCTAssertTrue(viewModel.isSecurePassword)
        viewModel.togglePasswordVisibility()
        XCTAssertFalse(viewModel.isSecurePassword)
        viewModel.togglePasswordVisibility()
        XCTAssertTrue(viewModel.isSecurePassword)
    }
    
    func testUsernameIsNotEmptyAfterEnteringText() {
        viewModel.username = "testuser"
        XCTAssertFalse(viewModel.username.isEmpty)
    }
    
    func testPasswordIsNotEmptyAfterEnteringText() {
        viewModel.password = "password123"
        XCTAssertFalse(viewModel.password.isEmpty)
    }
    
    func testPinIsNotEmptyAfterEnteringText() {
        viewModel.pin = 1111
        XCTAssertEqual(viewModel.pin, 0)
    }
    
    func testLoginFailsWhenUsernameIsEmpty() {
        viewModel.username = ""
        viewModel.password = "password"
        viewModel.pin = 1234
        
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginFailsWhenPasswordIsEmpty() {
        viewModel.username = "user"
        viewModel.password = ""
        viewModel.pin = 1234
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    
    
    func testLoginWithEmptyCredentials() {
        viewModel.username = ""
        viewModel.password = ""
        
        viewModel.login()
        
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertTrue(viewModel.loginFailed)
    }
    
    func testLoginShowsCorrectMessageAfterSuccessfulLogin() {
        viewModel.username = "user"
        viewModel.password = "password"
        
        viewModel.login()
        
        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertFalse(viewModel.loginFailed)
    }
    
    
    func testUsernameChangeUpdatesCorrectly() {
        viewModel.username = "newuser"
        XCTAssertEqual(viewModel.username, "newuser")
    }
    
    func testPasswordChangeUpdatesCorrectly() {
        viewModel.password = "newpassword"
        XCTAssertEqual(viewModel.password, "newpassword")
    }
    
    func testPinChangeUpdatesCorrectly() {
        viewModel.pin = 4321
        XCTAssertEqual(viewModel.password, "4321")
    }
    
    func testSecurePasswordIsTrueByDefault() {
        XCTAssertTrue(viewModel.isSecurePassword)
    }
    
    
}
