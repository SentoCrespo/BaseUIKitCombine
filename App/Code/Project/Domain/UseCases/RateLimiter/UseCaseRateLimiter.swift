import Foundation
import Combine

public enum UseCaseRateLimiter {

    /// Checks if a rate limit applies based on the last update and a time interval
    public static func isRateLimitActive(
        lastUpdate: Date?,
        currentDate: Date = Date(),
        limitInterval: TimeInterval = Constants.fetchLimitInSeconds
    ) -> Bool {
        guard let lastUpdate else {
            return false
        }
        return currentDate.timeIntervalSince(lastUpdate) <= limitInterval
    }

}
