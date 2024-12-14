import Foundation
import XCTest

class UITestsBase: XCTestCase {
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        CommonScreen().launchApplication()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension UITestsBase {}
