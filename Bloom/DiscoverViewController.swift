//
//  DiscoverViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreGraphics
import Foundation

// NOTE: Location spoofing has been moved to `Features` in update
// To spoof location, go to Simulator -> Features -> Location -> Apple (or whatever)

let key = Key.Google.placesKey

class DiscoverViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    // CLLocationManager is the object that gives GPS coordinates
    // Instantiate CLLocationManager
    let locationManager = CLLocationManager()
    
    @IBAction func getLocation() {
        // print("Key is: ", Key.Google.placesKey)
        
        // Authorization for permission
        let authStatus = CLLocationManager.authorizationStatus()
        
        // Check current authorization status; if .notDetermined
        // Means that the app has not asked for permission yet
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        // CLLocationManager does not give coordinates immediately
        // Have to invoke the class method, startUpdatedLocation() first
        locationManager.startUpdatingLocation()
        
        centerOnLocation()
    }
    
    @IBAction func cafe() {
        return
    }
    
    // MARK: - Map View
    let regionRadius: Double = 500
    
    // Center onto current location
    func centerOnLocation () {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerOnLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("didFailWithError \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdatedLocations \(newLocation)")
    }
    
    
    // MARK: - Helper Methods
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for this app in Settings.",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        // UIAlertController takes in a UIAlertAction argument
        // Read documentation of class for iOS 8.0 and above
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOnLocation()
        // Do any additional setup after loading the view.
    }
}
