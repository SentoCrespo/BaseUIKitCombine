import Foundation
import Combine

public extension Publisher {
    
    /// Applies a scheduler to the publisher, conditionally based on the build type.
    /// - Parameters:
    ///   - scheduler: The scheduler to apply if not in test mode.
    ///   - options: Options to pass to the scheduler (optional).
    /// - Returns: A publisher that optionally receives on the given scheduler.
    func receiveTestByPass<S: Scheduler>(
        on scheduler: S,
        options: S.SchedulerOptions? = nil
    ) -> AnyPublisher<Output, Failure> {
        if BuildType.isTest {
            // If in test mode, bypass `receive(on:)`
            return self.eraseToAnyPublisher()
        } else {
            // Apply `receive(on:)` in production
            return self
                .receive(on: scheduler, options: options)
                .eraseToAnyPublisher()
        }
    }
    
}
