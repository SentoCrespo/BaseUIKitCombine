import Foundation

extension OpenExchange {
    
    /// Creates a URLRequest for Open Exchange API
    static func build(path: String, queryItems: [URLQueryItem] = []) -> URLRequest {
        guard var baseURL = URL(string: Self.Constants.baseURL) else {
            // This is expected behavior since URLs are hardcoded
            // should always be valid.
            // Any failure here indicates a programming error
            fatalError("Invalid base URL")
        }
        
        // Append the endpoint
        baseURL.appendPathComponent(path)
        
        // Append parameters
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        guard let url = components?.url else {
            fatalError("Invalid URL components")
        }
        var request = URLRequest(url: url)
        request.addValue(
            "Token \(Self.Constants.appId)",
            forHTTPHeaderField: "Authorization"
        )
        return request
    }
    
}
