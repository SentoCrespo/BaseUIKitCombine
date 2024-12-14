import Foundation
import UIKit

public extension UIDevice {
    static var isSimulator: Bool {
        #if TARGET_OS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
}
