import Foundation

public struct PathUtils {}

// MARK: Public Methods

public extension PathUtils {
    static func documentsUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    static func cachesUrl() -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    static func addSkipBackupAttributeToItemAtURL(_ url: URL) -> Bool {
        let fileManager = FileManager.default
        
        let path = url.path
        
        guard fileManager.fileExists(atPath: path) else { return false }
        
        var changeUrl = url
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        
        do {
            try changeUrl.setResourceValues(resourceValues)
            
            return true
        } catch {
            return false
        }
    }
    
    static func fileSize(_ path: String) -> UInt64? {
        let fileManager = FileManager.default
        let attrs: NSDictionary? = try? fileManager.attributesOfItem(atPath: path) as NSDictionary?
        if let dict = attrs {
            return dict.fileSize()
        }
        return 0
    }
}
