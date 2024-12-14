import Foundation

public class JsonUtils {
    public static func readDictionary(resourceName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {
        guard let resourceUrl = bundle.url(forResource: resourceName, withExtension: "json") else {
            return nil
        }
        guard let content = try? String(contentsOf: resourceUrl) else {
            return nil
        }
        
        return readJson(content) as? [String: Any]
    }
    
    public static func readDictionaryData(resourceName: String, bundle: Bundle = Bundle.main) -> [String: Any]? {
        guard let jsonDict = self.readDictionary(resourceName: resourceName, bundle: bundle) else {
            return nil
        }
        
        guard let jsonData = jsonDict["data"] as? [String: Any] else {
            return nil
        }
        
        return jsonData
    }
    
    fileprivate static func readJson(_ content: String) -> Any? {
        guard let contentData = content.data(using: .utf8) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: contentData, options: [])
    }
}
