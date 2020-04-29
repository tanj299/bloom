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
// If there is no annotation(the blue dot that indicates your location), simulate location
// Hunter College Coordinates: 40.767954, -73.964572

let key = Key.Google.placesKey

class DiscoverViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // MARK: - General Location functions
    var updatingLocation = false
    var lastLocationError: Error?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    // CLLocationManager is the object that gives GPS coordinates
    // Instantiate CLLocationManager
    let locationManager = CLLocationManager()
    
    // Store user's current location in this variable
    // This is an optional since a user may not have a location
    var location: CLLocation?
    
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
        
        if updatingLocation {
            stopLocationManager()
        }
        
        // Clear out old location before looking for new location
        else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        updateLabels()
        
        centerOnLocation()
    }
    
    // Check whether location services are enabled
    // Set `updatingLocation` to true if start location updates
    func startLocationManager () {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func configureGetButton () {
        if updatingLocation {
            getButton.setTitle("Stop", for: .normal)
        }
        
        else {
            getButton.setTitle("Get My Location", for: .normal)
        }
    }
    
    @IBAction func cafe() {
        return
    }
    
    
    // MARK: - Map View and Function
    let regionRadius: Double = 500
    
    // Center onto current location
    func centerOnLocation () {
        guard let coordinate = locationManager.location?.coordinate else {return}
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - CLLocationManagerDelegate
    func updateLabels () {
        if let location = location {
            
            // String interpolation: Show 8 digits behind decimal point
            // Can also use: latitudeLabel.text = "\(location.coordinate.latitude)" but no control
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.isHidden = false
            messageLabel.text = "Gotcha!"
        }
        
        else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.isHidden = true
            
            let statusMessage: String
            if let error = lastLocationError as NSError? {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "Location Services Disabled"
                }
                
                else {
                    statusMessage = "Error Getting Location"
                }
            }
            
            else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            }
            
            else if updatingLocation {
                statusMessage = "Searching ... "
            }
            
            else {
                statusMessage = "Tap `Get My Location` to Start"
            }
            
            messageLabel.text = statusMessage
        }
        
        configureGetButton()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerOnLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("didFailWithError \(error.localizedDescription)")
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        
        lastLocationError = error
        stopLocationManager()
        updateLabels()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdatedLocations \(newLocation)")
        
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            lastLocationError = nil
            location = newLocation
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("***We're done!")
                stopLocationManager()
            }
            
            updateLabels()
        }
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
//        centerOnLocation()
        // Do any additional setup after loading the view.
    }
}
