//
//  MapPoint.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 4/18/23.
// Will be used to store the annotation (Pin) for a single point on the map 

import Foundation
import MapKit

class MapPoint: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init (latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
