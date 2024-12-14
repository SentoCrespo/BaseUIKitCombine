import Foundation
import Combine
import SharedUtils

extension URLSession {

    /// Performs a network request and decodes the response into a specified Decodable type.
    /// - Parameters:
    ///   - request: The URLRequest to execute.
    ///   - type: The type conforming to `Decodable` to decode the response into.
    /// - Returns: A publisher with the decoded object or an error.
    func perform<T: Decodable>(request: URLRequest, decoding type: T.Type) -> AnyPublisher<T, Error> {
        self.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { [weak self] output in
                self?.debugHTTPResponse(output.response, data: output.data)
            })
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
