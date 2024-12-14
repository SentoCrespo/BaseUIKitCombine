import Foundation
import Combine

func logMiddleware() -> ReduxMiddleware<AppReduxState, ReduxAction> {
    
    return { state, action in
        Swift.print("--- Redux action: \(action)")
        Swift.print("--- Redux state: \(state)")
        return Empty().eraseToAnyPublisher()
    }
    
}
