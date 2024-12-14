import Foundation
import Combine

public typealias ReduxMiddleware<ReduxState, ReduxAction> =
    (ReduxState, ReduxAction) -> AnyPublisher<ReduxAction, Never>
