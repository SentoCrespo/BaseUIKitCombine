import Foundation
import Combine
import XCTest

/// Utilities to ease combine methods with XCTest
extension XCTestCase {
    
    // MARK: - Properties
    typealias CompetionResult = (expectation: XCTestExpectation, cancellable: AnyCancellable)
    
    /// Expects Publisher to complete.
    /// Usage:
    /// let result = expectCompletion(of: Publisher)
    /// wait(for: [result.expectation], timeout: 1)
    func expectCompletion<T: Publisher>(of publisher: T,
                                        timeout: TimeInterval = 2,
                                        file: StaticString = #file,
                                        line: UInt = #line) -> CompetionResult {
        let exp = expectation(description: "Successful completion of " + String(describing: publisher))
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                if case .finished = completion {
                    exp.fulfill()
                }
            }, receiveValue: { _ in })
        return (exp, cancellable)
    }
    
    /// Expects Publisher to complete and be equal to a provided value.
    /// Usage:
    /// let result = expectValue(of: Publisher, equals: [output1, output2, ...])
    /// wait(for: [result.expectation], timeout: 1)
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [T.Output]) -> CompetionResult where T.Output: Equatable {
        let exp = expectation(description: "Correct values of " + String(describing: publisher))
        var mutableEquals = equals
        let cancellable = publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { value in
                    if value == mutableEquals.first {
                        mutableEquals.remove(at: 0)
                        if mutableEquals.isEmpty {
                            exp.fulfill()
                        }
                    }
            })
        return (exp, cancellable)
    }
    
    /// Expects Publisher to complete and be equal to a provided bool closure.
    /// Usage:
    /// let hasValue: (Output) -> Bool = { $0 == {TheTestValue} }
    /// let result = expectValue(of: Publisher, equals: [output1, output2, ...])
    /// wait(for: [result.expectation], timeout: 1)
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [(T.Output) -> Bool]) -> CompetionResult {
            let exp = expectation(description: "Correct values of " + String(describing: publisher))
            var mutableEquals = equals
            let cancellable = publisher
                .sink(receiveCompletion: { _ in },
                      receiveValue: { value in
                        if mutableEquals.first?(value) ?? false {
                            _ = mutableEquals.remove(at: 0)
                            if mutableEquals.isEmpty {
                                exp.fulfill()
                            }
                        }
                })
            return (exp, cancellable)
    }
    
}
