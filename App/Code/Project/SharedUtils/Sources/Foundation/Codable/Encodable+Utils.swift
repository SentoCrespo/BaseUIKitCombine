import Foundation

// MARK: Encodable

public extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    func toJson() -> [String: AnyHashable] {
        return self.toData()
            .flatMap {
                return try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            .flatMap { $0 as? [String: AnyHashable] } ?? [:]
    }
    
    func toJsonString() -> String? {
        guard let jsonData = self.toData() else {
            return nil
        }
        let result = String(data: jsonData, encoding: .utf8)
        return result
    }
}

public extension Array where Element: Encodable {
    func toJson() -> [[String: AnyHashable]] {
        return self.toData()
            .flatMap {
                return try? JSONSerialization.jsonObject(with: $0, options: [])
            }
            .flatMap { $0 as? [[String: AnyHashable]] } ?? []
    }
}
