import Foundation

// MARK: Decodable

public extension Decodable {
    static func parse(resourceName: String, withExtension: String = "json", bundle: Bundle = Bundle.main) -> Self? {
        guard let fileUrl = bundle.url(forResource: resourceName, withExtension: withExtension) else {
            return nil
        }
        do {
            let fileData = try Data(contentsOf: fileUrl)
            let result = Self.parse(from: fileData)
            return result
        } catch {
            return nil
        }
    }
    
    static func parse(from item: Any?) -> Self? {
        guard let data = self.data(from: item) else {
            return nil
        }
        do {
            let result = try JSONDecoder().decode(Self.self, from: data)
            return result
        } catch {
            return nil
        }
    }
    
    static func data(from item: Any?) -> Data? {
        switch item {
        case let data as Data:
            return data
        case let string as String:
            return string.data(using: .utf8)
        case .some(let item):
            return try? JSONSerialization.data(withJSONObject: item, options: [])
        case nil:
            return nil
        }
    }
}
