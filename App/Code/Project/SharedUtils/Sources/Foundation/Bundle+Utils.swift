import Foundation

public extension Bundle {
    
    var versionNumber: String? {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        return self.infoDictionary?["CFBundleVersion"] as? String
    }
    
    var versionFormatted: String? {
        let result = "v. \(self.versionNumber!) (\(self.buildNumber!))"
        return result
    }
}
