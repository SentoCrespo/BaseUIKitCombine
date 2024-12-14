@testable import Project
import Foundation

extension AppReduxStore {
    
    static func mock() -> AppReduxStore {
        let initialState = AppReduxState.initial
        let store = AppReduxStore(
            initialState: initialState,
            reducer: AppReducer.reducer,
            middlewares: []
        )
        return store
    }
    
}
