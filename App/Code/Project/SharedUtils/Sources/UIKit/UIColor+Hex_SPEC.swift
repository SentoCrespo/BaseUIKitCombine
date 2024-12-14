@testable import SharedUtils
import XCTest

class TestsUIColorHex: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

extension TestsUIColorHex {
    func testFromStringAndBackNoAlpha() {
        // Given
        let input = "#b3b4b5"
        
        // When
        let resultColor = UIColor(hex: input)
        let resultColorString = resultColor?.hexString(withAlpha: false)
        
        // Then
        XCTAssertEqual(input.uppercased(), resultColorString?.uppercased())
    }
    
    func testFromStringAndBackAlpha() {
        // Given
        let input = "#b3b4b502"
        
        // When
        let resultColor = UIColor(hex: input)
        let resultColorString = resultColor?.hexString(withAlpha: true)
        
        // Then
        XCTAssertEqual(input.uppercased(), resultColorString?.uppercased())
    }
}
