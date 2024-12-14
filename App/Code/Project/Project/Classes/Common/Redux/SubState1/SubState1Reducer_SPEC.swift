import Foundation
import Testing

@testable import Project

final class SubState1ReducerTests {
    
    init() {}
    
    deinit {}
    
}

extension SubState1ReducerTests {
    
    /// GIVEN:
    ///  -
    /// WHEN:
    ///  -
    ///  THEN:
    ///  -
    @Test
    func sample() {
        // Given
        let store: AppReduxStore = .init(
            initialState: .initial,
            reducer: AppReducer.reducer,
            middlewares: []
        )
        
        // When
        let action = SubState1Action.myAction
        store.dispatch(action)
        
        // Then
        #expect(store.state.subState1.myGlobalVar == "Changed")
    }
    
}
