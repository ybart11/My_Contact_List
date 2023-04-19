//
//  MapViewController.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 3/28/23.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager: CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    
    var contacts: [Contact] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.2
        span.longitudeDelta = 0.2
        
        let viewRegion = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(viewRegion, animated: true)
        
        let mp = MapPoint(latitude: userLocation.coordinate.latitude,
                          longitude: userLocation.coordinate.longitude)
        
        mp.title = "You"
        mp.subtitle = "Are here"
        mapView.addAnnotation(mp)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get contacts from Core Data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        var fetchedObjects: [NSManagedObject] = []
        do {
            fetchedObjects = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // Convert to array of Contact objects
        contacts = fetchedObjects as! [Contact]
        
        // Remove all annotations
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        // Go through all contacts
        for contact in contacts { // as! [Contact] {
            let address = "\(contact.streetAddress!), \(contact.city!) \(contact.state!)"
            
            // Geocoding
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address, completionHandler: {(placemarks, error) in self.processAddressResponse(contact, withPlacemarks: placemarks, error: error)
            
            })
        }
    }
    
    private func processAddressResponse(_ contact: Contact, withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print ("Geocode Error: \(error)")
        }
        else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = placemarks.first?.location
            }
            if let coordinate = bestMatch?.coordinate {
                let mp = MapPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                mp.title = contact.contactName
                mp.subtitle = contact.streetAddress
                mapView.addAnnotation(mp)
            }
            else {
                print("Didn't find any matching locations")
            }
        }
        
    }
    
    // Enables showing the user location
    @IBAction func findUser(_ sender: Any) {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

}
