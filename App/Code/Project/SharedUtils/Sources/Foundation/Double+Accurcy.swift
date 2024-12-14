import Foundation

public extension Double {
    
    /// Compares two `Double` values within a specified tolerance.
    func isEqual(to other: Double, tolerance: Double = 0.0001) -> Bool {
        return abs(self - other) <= tolerance
    }
    
}
