import Foundation
import Combine
import Testing

/// Utilities to ease combine methods with Testing
public extension Publisher {
    
    /// Expects Publisher to emit a value.
    /// Usage:
    /// ```
    /// .sinkSuccess {
    ///    #expect(...)
    /// }
    /// ```
    func sinkWithValue(
            _ receiveValue: @escaping (Output) -> Void
        ) -> AnyCancellable {
            self.sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        Issue.record("Expected success but got error: \(error.localizedDescription)")
                    }
                },
                receiveValue: receiveValue
            )
        }
    
    /// Expects Publisher to fail with error .
    /// Usage:
    /// ```
    /// .sinkFailure {
    ///    #expect(...)
    /// }
    /// ```
    func sinkWithFailure(
        _ receiveError: @escaping (Failure) -> Void
    ) -> AnyCancellable {
        self.sink(
            receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    receiveError(error)
                }
            },
            receiveValue: { _ in
                Issue.record("Expected failure but got success.")
            }
        )
    }
    
}
