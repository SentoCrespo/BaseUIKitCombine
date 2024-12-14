import Foundation
import MapKit

public extension MKMapView {
    var zoomLevel: Int {
        let zoomWidth = self.visibleMapRect.size.width
        let zoomLevel = Int(log2(zoomWidth))
        return zoomLevel
    }
}
