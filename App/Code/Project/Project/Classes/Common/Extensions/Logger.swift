import Foundation
import OSLog

extension Logger {
    
    // MARK: - Properties
    private static let subsystem = Bundle.main.bundleIdentifier!
    
}

enum LoggerCategories: String {
    case app
    case viewCycle
    case analytics
    case navigation
    case stateMachine
    case redux
}

// MARK: - Accessible Methods
extension Logger {
    
    static let app = Logger(category: .app)
    static let viewCycle = Logger(category: .viewCycle)
    static let analytics = Logger(category: .analytics)
    static let navigation = Logger(category: .navigation)
    static let stateMachine = Logger(category: .stateMachine)
    static let redux = Logger(category: .redux)
    
}

// MARK: - Private Methods
private extension Logger {
    
    /// Inits the given category
    /// Enalbes logs only in debug
    init(category: LoggerCategories) {
#if DEBUG
        self.init(
            subsystem: Logger.subsystem,
            category: category.rawValue
        )
#else
        return OSLog.disabled
#endif
    }
    
}
