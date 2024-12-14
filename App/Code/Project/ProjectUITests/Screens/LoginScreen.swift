import Foundation
import XCTest

class LoginScreen: CommonScreen {}

extension LoginScreen {
    func verifyScreenIsVisible() {
        let element = AccessibilityId.login.btLogin.rawValue
        waitForElementToAppear(type: .button, id: element)
        verifyUIElementExists(.button, id: element)
    }
}
