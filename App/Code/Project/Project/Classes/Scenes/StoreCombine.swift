import Foundation
import Combine

public protocol StoreCombine {
    associatedtype ModelState: Equatable
    var state: CurrentValueSubject<ModelState, Never> { get }
}

public extension StoreCombine {
    typealias ExtractorOptional<T: Equatable> = (ModelState) -> T?
    typealias Extractor<T: Equatable> = (ModelState) -> T
    
    func getValue<T: Equatable>(_ extractor: @escaping Extractor<T>) -> T {
        return extractor(self.state.value)
    }
    
    func getOptionalValue<T: Equatable>(_ extractor: @escaping ExtractorOptional<T>) -> T? {
        return extractor(self.state.value)
    }
    
    func getChanges<T: Equatable>(_ element: @escaping Extractor<T>) -> AnyPublisher<T, Never> {
        return self.state
            .map { element($0) }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    func getUpdates<T>(_ element: @escaping Extractor<T>) -> AnyPublisher<T, Never> {
        return self.state
            .map { element($0) }
            .eraseToAnyPublisher()
    }
    
    typealias StoreCombineReducer = (inout ModelState) -> Void
    func newState(_ reducer: StoreCombineReducer) {
        var state = self.state.value
        reducer(&state)
        self.state.send(state)
    }
}
