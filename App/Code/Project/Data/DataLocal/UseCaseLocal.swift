import Foundation
import Combine

// sourcery:AutoInit
public class UseCaseLocal<T: Decodable> {
    
    // MARK: - Properties
    private let bundle: Bundle
    private let filename: String
    
    // sourcery:inline:auto:UseCaseLocal.AutoInit
        // MARK: - Life Cycle
        public init(
            bundle: Bundle,
            filename: String
            ) {
    		self.bundle = bundle
    		self.filename = filename
    	}
    // sourcery:end
        
    // MARK: - Public Methods
    public func fetch() -> AnyPublisher<T, Error> {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            let error = NSError(domain: "FileNotFound", code: 1)
            return Fail(error: error).eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return Just(decoded)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
