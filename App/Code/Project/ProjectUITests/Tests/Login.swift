import Foundation
import XCTest

class UITestsLogin: UITestsBase {
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        CommonScreen().launchApplication()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension UITestsLogin {
    func test_login_correct() {
        // Given
        
        // When
        
        // Then
    }
    
    func test_login_incorrect() {
        // Given
        
        // When
        
        // Then
    }
}
