import Foundation

public extension URLSession {

    /// Logs the HTTP response and body for debugging purposes.
    /// - Parameters:
    ///   - response: The HTTPURLResponse from the request.
    ///   - data: The raw data received from the request.
    func debugHTTPResponse(_ response: URLResponse, data: Data) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response object.")
            return
        }
        
        // HTTP status
        print("HTTP Response:")
        print("Status Code: \(httpResponse.statusCode)")
        
        // Headers
        print("Headers:")
        for (key, value) in httpResponse.allHeaderFields {
            print("\(key): \(value)")
        }
        
        // Body
        if let bodyString = String(data: data, encoding: .utf8) {
            print("Body:")
            print(bodyString)
        } else {
            print("Body: (Unable to decode body as UTF-8 string)")
        }
    }
    
}
