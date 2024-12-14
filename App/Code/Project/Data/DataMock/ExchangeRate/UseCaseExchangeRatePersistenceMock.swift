import Foundation
import Combine

// sourcery:AutoInit
public final class UseCaseExchangeRatePersistenceMock: UseCaseExchangeRatePersistence {
    
    // MARK: - Properties
    public typealias ResultLoadRatesType = Result<ExchangeRates, Error>
    private var resultLoadRates: ResultLoadRatesType!
    public typealias ResultSaveRatesType = Result<Void, Error>
    private var resultSaveRates: ResultSaveRatesType!
   
    // sourcery:inline:auto:UseCaseExchangeRatePersistenceMock.AutoInit
        // MARK: - Life Cycle
        public init(
            resultLoadRates: ResultLoadRatesType! = nil,
            resultSaveRates: ResultSaveRatesType! = nil
            ) {
    		self.resultLoadRates = resultLoadRates
    		self.resultSaveRates = resultSaveRates
    	}
    // sourcery:end
}

// MARK: - UseCaseExchangeRatePersistence
public extension UseCaseExchangeRatePersistenceMock {
    
    func load() -> AnyPublisher<ExchangeRates, Error> {
        switch resultLoadRates! {
            case .success(let value):
                return Just(value)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
        }
    }
    
    func save(exchangeRates: ExchangeRates) -> AnyPublisher<Void, any Error> {
        switch resultSaveRates! {
            case .success:
                return Just(())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                
            case .failure(let error):
                return Fail(error: error)
                    .eraseToAnyPublisher()
        }
    }
    
}

// MARK: - Public Methods
public extension UseCaseExchangeRatePersistenceMock {
    
    func withLoadData(_ result: ResultLoadRatesType) -> Self {
        self.resultLoadRates = result
        return self
    }
    
    func withSaveData(_ result: ResultSaveRatesType) -> Self {
        self.resultSaveRates = result
        return self
    }
    
}
