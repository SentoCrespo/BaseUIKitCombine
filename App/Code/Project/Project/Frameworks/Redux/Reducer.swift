import Foundation

public typealias ReduxReducer<ReduxState, ReduxAction> = (inout ReduxState, ReduxAction) -> Void
