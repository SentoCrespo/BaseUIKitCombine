import Foundation
import Testing
import Combine
import SharedUtils
@testable import Domain

class UseCaseRateLimiterTests {
    
    // MARK: - Properties
    
    /// GIVEN: Rate limit does not apply one second before it
    /// WHEN: Calculating rate limitation
    /// THEN: Rate limitation should be false
    @Test
    func testRateLimitInactive_beforeRateLimit() {
        // Given
        let currentDate = self.testDate
        let limitInterval = Constants.fetchLimitInSeconds
        let secondsDifferenceRateLimit: TimeInterval = 1
        let lastUpdate = currentDate.timeIntervalSince1970 - limitInterval - secondsDifferenceRateLimit
        
        // When
        let isRateLimited = UseCaseRateLimiter.isRateLimitActive(
            lastUpdate: Date(timeIntervalSince1970: lastUpdate),
            currentDate: currentDate,
            limitInterval: limitInterval
        )
        
        // Then
        #expect(isRateLimited == false)
    }
    
    /// GIVEN: Rate limit applies just on limit
    /// WHEN: Calculating rate limitation
    /// THEN: Rate limitation should be true
    @Test
    func testRateLimitInactive_justOnRateLimit() {
        // Given
        let currentDate = self.testDate
        let limitInterval = Constants.fetchLimitInSeconds
        let lastUpdate = currentDate.timeIntervalSince1970 - limitInterval
        
        // When
        let isRateLimited = UseCaseRateLimiter.isRateLimitActive(
            lastUpdate: Date(timeIntervalSince1970: lastUpdate),
            currentDate: currentDate,
            limitInterval: limitInterval
        )
        
        // Then
        #expect(isRateLimited == true)
    }
    
    /// GIVEN: Rate limit applies one second after the limit
    /// WHEN: Calculating rate limitation
    /// THEN: Rate limitation should be true
    @Test
    func testRateLimitActive() {
        // Given
        let currentDate = self.testDate
        let limitInterval = Constants.fetchLimitInSeconds
        let secondsDifferenceRateLimit: TimeInterval = 1
        let lastUpdate = currentDate.timeIntervalSince1970 - limitInterval + secondsDifferenceRateLimit
        
        // When
        let isRateLimited = UseCaseRateLimiter.isRateLimitActive(
            lastUpdate: Date(timeIntervalSince1970: lastUpdate),
            currentDate: currentDate,
            limitInterval: limitInterval
        )
        
        // Then
        #expect(isRateLimited == true)
    }
    
    /// GIVEN: No last update is stored
    /// WHEN: Calculating rate limitation
    /// THEN: Rate limitation should be false
    @Test
    func testRateLimitNoLastUpdate() {
        // Given
        let currentDate = self.testDate
        let lastUpdate: Date? = nil
        let limitInterval = Constants.fetchLimitInSeconds
        
        // When
        let isRateLimited = UseCaseRateLimiter.isRateLimitActive(
            lastUpdate: lastUpdate,
            currentDate: currentDate,
            limitInterval: limitInterval
        )
        
        // Then
        #expect(isRateLimited == false)
    }
    
}

private extension UseCaseRateLimiterTests {
    
    var testDate: Date {
        let calendar = Calendar.current
        let result = calendar.date(
            from: DateComponents(
                year: 1987,
                month: 2,
                day: 9
            )
        )
        return result!
    }
    
}
