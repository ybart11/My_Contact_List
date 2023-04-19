//
//  MapViewController.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 3/28/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!

    
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.2
        span.longitudeDelta = 0.2
        
//        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

        mapView.setRegion(viewRegion, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // Enables showing the user location
    @IBAction func findUser(_ sender: Any) {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }

}
