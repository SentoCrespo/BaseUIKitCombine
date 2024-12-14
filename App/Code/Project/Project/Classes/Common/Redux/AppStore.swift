import Foundation

typealias AppReduxStore = ReduxStore<AppReduxState, ReduxAction>

let store: AppReduxStore = AppReduxStore(
    initialState: AppReduxState.initial,
    reducer: AppReducer.reducer,
    middlewares: [
        logMiddleware()
    ]
)
