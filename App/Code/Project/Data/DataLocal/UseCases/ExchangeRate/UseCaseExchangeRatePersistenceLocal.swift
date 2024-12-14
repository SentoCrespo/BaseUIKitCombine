import Foundation
import Combine

public final class UseCaseExchangeRatePersistenceDisk: UseCaseExchangeRatePersistence {
    
    // MARK: - Properties
    private let fileManager: FileManager
    private let directory: URL
    
    struct Constants {
        static let filename: String = "exchangeRates.json"
    }
    
    // MARK: - Init
    public init(fileManager: FileManager = .default, directory: URL? = nil) {
        self.fileManager = fileManager
        self.directory = directory ?? fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first! // swiftlint:disable:this force_cast
    }
    
}

// MARK: - UseCaseExchangeRatePersistence
public extension UseCaseExchangeRatePersistenceDisk {
    
    // MARK: - UseCaseExchangeRatePersistenceDatasource
    func save(exchangeRates: ExchangeRates) -> AnyPublisher<Void, Error> {
        let saveURL = directory.appendingPathComponent(Constants.filename)
        do {
            let data = try JSONEncoder().encode(exchangeRates)
            try data.write(to: saveURL)
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    func load() -> AnyPublisher<ExchangeRates, Error> {
        let loadURL = directory.appendingPathComponent(Constants.filename)
        do {
            let data = try Data(contentsOf: loadURL)
            let result = try JSONDecoder().decode(ExchangeRates.self, from: data)
            return Just(result)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
}
