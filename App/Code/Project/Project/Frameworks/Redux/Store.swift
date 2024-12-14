import Foundation
import Combine

/// Holds the State of the app (read-only access)
public final class ReduxStore<ReduxState, ReduxAction>: ObservableObject {
    
    // MARK: - Typealias
    typealias Reducer = ReduxReducer<ReduxState, ReduxAction>
    typealias Middleware = ReduxMiddleware<ReduxState, ReduxAction>
    
    // MARK: - Properties
    @Published private(set) public var state: ReduxState // Read-only access to app state
    private let reducer: Reducer
    
    // Middleware
    var tasks: [AnyCancellable] = []
    let serialQueue = DispatchQueue(label: "redux.serial.queue")
    let middlewares: [Middleware]
    private var middlewareCancellables: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    init(initialState: ReduxState,
         reducer: @escaping Reducer,
         middlewares: [Middleware]) {
        self.state = initialState
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
}
    
public extension ReduxStore {
    
    /// Dispatches actions to the reducer & middlewares
    func dispatch(_ action: ReduxAction) {
        
        // Ensure actions are dispatched in order
        self.serialQueue.sync {
            reducer(&state, action)
        }
        
        self.middlewares.forEach {
            let middleware = $0(state, action)
            middleware
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &middlewareCancellables)
        }
    }
    
}

import SwiftUI
extension ReduxStore {
        
    typealias Extractor<T: Equatable> = (ReduxState) -> T
    typealias ExtractorOptional<T: Equatable> = (ReduxState) -> T?
    func getValue<T: Equatable>(_ extractor: @escaping Extractor<T>) -> T {
        return extractor(self.state)
    }
    
    func getOptionalValue<T: Equatable>(_ extractor: @escaping ExtractorOptional<T>) -> T? {
        return extractor(self.state)
    }
    
    func getChanges<T: Equatable>(whenThisElementChanges: @escaping Extractor<T>) -> AnyPublisher<T, Never> {
        return self.$state
            .map { whenThisElementChanges($0) }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func getUpdates<T: Equatable>(whenThisElementUpdates: @escaping Extractor<T>) -> AnyPublisher<T, Never> {
        return self.$state
            .map { whenThisElementUpdates($0) }
            .eraseToAnyPublisher()
    }
    
}

extension Publisher {
    
    func getChanges() -> AnyPublisher<Output, Failure> where Output: Equatable {
        return debounce(
            for: .milliseconds(300),
            scheduler: DispatchQueue.main
        )
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
    
}
