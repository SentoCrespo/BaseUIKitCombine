import Foundation

extension Date {
    var dateString: String? {
        let template = "yyyy-MM-dd"
        let result = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)!
        return result
    }
    
    var timeString: String? {
        let template = "yyyy-MM-dd HH:mm:ss"
        let result = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: Locale.current)!
        return result
    }
    
    var dateAndtimeString: String? {
        let components = [
            self.dateString,
            self.timeString
        ].compactMap {
            return $0
        }.map {
            return "\($0)"
        }
        let result = components.joined(separator: " · ")
        return result
    }
}

extension TimeInterval {
    var date: Date {
        return Date(timeIntervalSince1970: self)
    }
    
    var dateString: String? {
        return self.date.dateString
    }
    
    var timeString: String? {
        return self.date.timeString
    }
    
    var dateAndtimeString: String? {
        return self.date.dateAndtimeString
    }
}
