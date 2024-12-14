import Foundation
import MapKit

extension MKMapView {
    var coordinateNE: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: mRect.maxX, y: mRect.origin.y)
    }
    
    var coordinateNW: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: mRect.minX, y: mRect.origin.y)
    }
    
    var coordinateSE: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: mRect.maxX, y: mRect.maxY)
    }
    
    var coordinateSW: CLLocationCoordinate2D {
        let mRect = self.visibleMapRect
        return self.coordinateFrom(x: mRect.origin.x, y: mRect.maxY)
    }
    
    func coordinateFrom(x: Double, y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        return swMapPoint.coordinate
    }
}
