import Foundation
import Combine

// sourcery:AutoInit
public final class UseCaseExchangeRateDatasourceMock: UseCaseExchangeRateDatasource {
    
    // MARK: - Properties
    private var resultFetchRates: Result<ExchangeRates, Error>!

    
    // sourcery:inline:auto:UseCaseExchangeRateDatasourceMock.AutoInit
    
        // MARK: - Life Cycle
    
        public init(
    
            resultFetchRates: Result<ExchangeRates, Error>! = nil
    
            ) {
    
    		self.resultFetchRates = resultFetchRates
    
    	}
    // sourcery:end
    
    // MARK: - UseCaseExchangeRateDatasource
    
    public func fetchRates() -> AnyPublisher<ExchangeRates, Error> {
        switch resultFetchRates! {
            case .success(let value):
                return Just(value)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
        }
    }
    

}

// MARK: - Public Methods
public extension UseCaseExchangeRateDatasourceMock {
    
    func withExchangeRates(_ result: Result<ExchangeRates, Error>) -> Self {
        self.resultFetchRates = result
        return self
    }
    
}
