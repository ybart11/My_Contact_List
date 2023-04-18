//
//  LocationDemoViewController.swift
//  My Contact List
//
//  Created by Yovany Bartolome on 4/18/23.
//

import UIKit
import CoreLocation

class LocationDemoViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblLocationAccuracy: UILabel!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblHeadingAccuracy: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblAltitudeAccuracy: UILabel!
    
    lazy var geoCoder = CLGeocoder()
    
    var locationManager: CLLocationManager!
    
    @objc func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        // Set up location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Ask for permission to use location, matches Plist

    }
    
    // Called when the location permission status changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            print("Permission granted")
        }
        else {
            print("Permission NOT granted")
        }
    }
    
    @IBAction func addressToCoordinates(_ sender: Any) {
        let address = "\(txtStreet.text!), \(txtCity.text!), \(txtState.text!)"
        
        geoCoder.geocodeAddressString(address, completionHandler: {(placemarks, error) in self.processAddressResponse(withPlacemarks: placemarks, error: error)
            
        })
    }
    
    private func processAddressResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Geocode Error: \(error)")
        }
        else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = placemarks.first?.location
            }
            
            if let coordinate = bestMatch?.coordinate {
                lblLatitude.text = String(format: "%g\u{00B0}", coordinate.latitude)
                lblLongitude.text = String(format: "%g\u{00B0}", coordinate.longitude)
            }
            else {
                print("Didn't find any matching locations")
            }
        }
    }
    
    @IBAction func deviceCoordinates(_ sender: Any) {
    }
    
    
    
    
    
    
    
    

}
