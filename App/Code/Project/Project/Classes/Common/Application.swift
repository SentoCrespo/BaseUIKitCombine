import Foundation

class Application: ObservableObject {
    
    // MARK: - Properties
    static let shared = Application()
    
    // MARK: Redux
    @Published var store: AppReduxStore
    
    // MARK: - Life Cycle
    private init() {
        let initialState = AppReduxState.initial
        let store: AppReduxStore = AppReduxStore(
            initialState: initialState,
            reducer: AppReducer.reducer,
            middlewares: [
                logMiddleware()
            ]
        )
        self.store = store
    }
    
}
