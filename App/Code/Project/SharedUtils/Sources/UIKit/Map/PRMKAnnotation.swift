import Foundation
import MapKit

protocol PRMKAnnotation: MKAnnotation {
    associatedtype MapItem
    
    // Properties
    var item: MapItem { get set }
    var coordinate: CLLocationCoordinate2D { get }
    
    // Life Cycle
    init(_ item: MapItem)
}
