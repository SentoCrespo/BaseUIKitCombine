import Foundation

struct SubState1: ReduxState {
    
    // MARK: - Properties
    var myGlobalVar: String
    
}

extension SubState1: Equatable, Hashable {}
