import Foundation
import XCTest

class CommonScreen: XCTestCase {
    // MARK: Properties
    
    let application: XCUIApplication = XCUIApplication()
    
    // MARK: Life Cycle
}

extension CommonScreen {
    func launchApplication() {
        application.launchArguments += ["UI-Testing"]
        application.launch()
    }
    
    func verifyUIElementExists(_ type: XCUIElement.ElementType, id: String) {
        XCTAssert(application.descendants(matching: type)[id].exists)
    }
    
    func tapButton(id: String, application: XCUIApplication = XCUIApplication()) {
        let button = application.buttons[id]
        button.tap()
    }
    
    func tapImage(id: String, application: XCUIApplication = XCUIApplication()) {
        let image = application.images[id]
        image.tap()
    }
    
    func waitForElementToAppear(type: XCUIElement.ElementType, id: String) {
        let element = application.descendants(matching: type)[id]
        return waitForElementToAppear(element)
    }
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
}

extension XCUIElement {
    func clearAndEnterText(_ text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        
        self.typeText(deleteString)
        self.typeText(text)
    }
    
    func pullToRefresh() {
        let firstCell = self.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 3))
        start.press(forDuration: 0, thenDragTo: finish)
    }
}
