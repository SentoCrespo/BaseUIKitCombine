import Foundation

// sourcery:AutoInit
public struct ExchangeRates: Codable {
    public let disclaimer: String
    public let license: String
    public let timestamp: TimeInterval
    public let base: String
    public let rates: [String: Double]

    // sourcery:inline:auto:ExchangeRates.AutoInit
        // MARK: - Life Cycle
        public init(
            disclaimer: String,
            license: String,
            timestamp: TimeInterval,
            base: String,
            rates: [String: Double]
            ) {
    		self.disclaimer = disclaimer
    		self.license = license
    		self.timestamp = timestamp
    		self.base = base
    		self.rates = rates
    	}
    // sourcery:end
}
extension ExchangeRates: Equatable & Hashable {}

// MARK: - Utils
public extension ExchangeRates {
    
    var currencies: [String] {
        let result =  rates.keys.sorted()
        return result
    }
    
}
