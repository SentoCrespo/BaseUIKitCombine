import Foundation

struct AppReducer {}

extension AppReducer {
    
    static func reducer(state: inout AppReduxState, action: ReduxAction) {
        switch action {
            case let substate1Action as SubState1Action:
                SubState1Reducer.reducer(
                    state: &state,
                    action: substate1Action)
            default:
                assertionFailure("Action should be handled with a specific type: \(action)")
        }
    }
    
}
