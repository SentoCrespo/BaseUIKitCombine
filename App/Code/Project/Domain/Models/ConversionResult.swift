import Foundation

/// Represents the result of a single currency conversion
// sourcery:AutoInit
public struct ConversionResult {
    
    // MARK: - Properties
    public let targetCurrency: String
    public let convertedAmount: Double
    // sourcery:inline:auto:ConversionResult.AutoInit
        // MARK: - Life Cycle
        public init(
            targetCurrency: String,
            convertedAmount: Double
            ) {
    		self.targetCurrency = targetCurrency
    		self.convertedAmount = convertedAmount
    	}
    // sourcery:end

}
extension ConversionResult: Equatable & Hashable {}
