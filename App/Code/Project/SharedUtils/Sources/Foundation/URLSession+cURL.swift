import Foundation

public extension URLRequest {
    
    /// Generates a `curl` command equivalent to the URLRequest for debugging purposes.
    /// - Returns: A string representing the `curl` command.
    func cURL() -> String {
        var components: [String] = ["curl -v"]
        
        // Method
        if let method = self.httpMethod {
            components.append("-X \(method)")
        }
        
        // Headers
        if let headers = self.allHTTPHeaderFields {
            for (key, value) in headers {
                components.append("-H '\(key): \(value)'")
            }
        }
        
        // Body
        if let httpBody = self.httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            components.append("-d '\(bodyString)'")
        }
        
        // URL
        if let url = self.url {
            components.append("'\(url.absoluteString)'")
        }
        
        return components.joined(separator: " \\\n")
    }
}
