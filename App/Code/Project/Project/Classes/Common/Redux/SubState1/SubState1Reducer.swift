import Foundation

struct SubState1Reducer {}

extension SubState1Reducer {
    
    static func reducer(state: inout AppReduxState, action: SubState1Action) {
        switch(action) {
            case .myAction:
                state.subState1.myGlobalVar = "Changed"
        }
    }
    
}
