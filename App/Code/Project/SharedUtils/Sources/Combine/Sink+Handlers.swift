import Foundation
import Combine

public extension Publisher {
    
    func sink(
        receiveSubscription: ((Subscription) -> Void)? = nil,
        receiveValue: ((Output) -> Void)? = nil,
        receiveError: ((Failure) -> Void)? = nil,
        receiveCompletion: ((Bool) -> Void)? = nil
    ) -> Cancellable {
        
        return self
            .handleEvents(
                receiveSubscription: { subscription in
                    receiveSubscription?(subscription)
                })
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            receiveCompletion?(true)
                        case .failure(let error):
                            receiveError?(error)
                            receiveCompletion?(false)
                    }
                },
                receiveValue: { value in
                    receiveValue?(value)
                }
            )
    }
    
}
