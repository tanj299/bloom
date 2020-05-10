//
//  DiscoverNewViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 5/7/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit
import CoreLocation

// NOTE: Location spoofing has been moved to `Features` in update
// To spoof location, go to Simulator -> Features -> Location -> Apple (or whatever)
// If there is no annotation(the blue dot that indicates your location), simulate location
// Hunter College Coordinates: 40.767962, -73.964207
// Sample Query for `cafe` near Hunter College: Radius: 200m, Type: cafe
// https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=40.767962,-73.964572&radius=200&type=cafe&key=AIzaSyChSr1L3g4pm6qdREQni1qzNUvPaUU-9yw


class DiscoverNewViewController: UIViewController, CLLocationManagerDelegate {
    
// MARK: - URLSession Variables
//    let defaults = UserDefaults.standard
    
    var searchResults = [SearchResult]()
    var cafesInRange = [CafeInRange]()
    var cafe = CafeInRange()
    var closestLocationCoordinates = 0.0
    var minDistance = 100000000000.0
    var closestCafeName = ""
    var closestCafeAddress = ""
    @IBOutlet weak var closestCafeButton: UIButton!
    @IBOutlet weak var closestCafeLabel: UILabel!
    @IBOutlet weak var closestCafeAddressLabel: UILabel!
    
    // Use lazy var because this property cannot be accessed until after a `self` is initialized
    lazy var myLocation = CLLocation(latitude: 0, longitude: 0)
    
    // REST call to Google Places API; fetch locations
    @IBAction func getClosestCafeButton() {
        asyncCall()
    }
    
    func parse(data: Data) -> [SearchResult] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        }
        catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
// MARK: - Variables and Instances
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!

    
    // CLLocation object that gives GPS coordinates
    // However, it doens't give location right away - use startUpdatingLocation()
    let locationManager = CLLocationManager()
    
    // Store user's location in this variable as an optional
    var location: CLLocation?
    
    var updatingLocation = false
    var lastLocationError: Error?
    
    // Geocoding
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    // Timer
    var timer: Timer?
    
    // Location Name
    var locationName: String?
    
    // Latitude and Longitude
    // Not using optionals to aid in code readability
    var myLatitude: Double = 0.0
    var myLongitude: Double = 0.0
    
    
// MARK: - Actions
    
    // Obtain location - this is an asynchronous process
    @IBAction func getLocation() {
        // Authorize app for using location
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // If authorization is denied or restricted show alert
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        // If app is updating location, stop the location manager
        if updatingLocation {
            stopLocationManager()
        }
        
        else {
            location = nil
            lastLocationError = nil
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        
        updateLabels()
    }
    
    
// MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
        
        // CLError.locationUnknown means unable to obtain location for now
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        
        lastLocationError = error
        stopLocationManager()
        updateLabels()
    }
    
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        
        // If the time at the current location was determined is too long ago
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        // Measure the radius of circle determined by the latitude and longitude
        // Negative values are invalid latitude and longitude
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        // DOUBLE_MAX of the type, CLLocationDistance
        var distance = CLLocationDistance(Double.greatestFiniteMagnitude)
        
        if let location = location {
            distance = newLocation.distance(from: location)
        }
        
        // Determine if new reading is more useful than the previous one
        // Check if the accuracy of the current location is greater than the new location
        // In this case, accuracy is measured by meters (ie. 100 meters accuracy is LESS ACCURATE than an accuracy of 10 meters)
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            lastLocationError = nil
            location = newLocation
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("We're good!")
                stopLocationManager()
            }
            
            // Force reverse geocoding for final location
            if distance > 0 {
                performingReverseGeocoding = false
            }
            
            updateLabels()
            
            // Perform geocoding one time only
            if !performingReverseGeocoding {
                print("*** Geocode")
                performingReverseGeocoding = true
                
                // Use a closure to get error message instead of using a delegate
                geocoder.reverseGeocodeLocation(newLocation, completionHandler: {
                    placemarks, error in
                    self.lastGeocodingError = error
                    
                    // Unwrap the optional (placemarks) and alias it as 'p'
                    // Enter statement if array of the placemark object is not empty
                    if error == nil, let p = placemarks, !p.isEmpty {
                        
                        // Take the last CLPlacemark object; it is an optional if there is no last item
                        // There is only usually one CLPlacemark object in the array
                        self.placemark = p.last!
                        
                        // Access name of the place since it is an array
                        // To deal with string interpolation warning, unwrap placemark and name
                        // self.locationName = self.placemark!.name!
                    }
                    else {
                        self.placemark = nil
                    }
                    
                    self.performingReverseGeocoding = false
                    self.updateLabels()

                })
            }
        }
        
        // If coordinate is not significantly different than previous and its greater than 10, stop reading location
        else if distance < 1 {
            let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
            if timeInterval > 10 {
                print("*** Force done!")
                stopLocationManager()
                updateLabels()
            }
        }
    }
    
    
// MARK: - Helper Functions
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services for this app in Settings.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Update UILabels displayed in ViewController
    // @Return: Label.Text of latitude, longitude, status message, etc.
    func updateLabels() {
        // If a location exists - update the UILabel's text with their coordinates
        // We have to unwrap the optional using `if let`
        if let location = location {
            
            // Show latitude / longitude with 8 digits behind decimal
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
//            tagButton.isHidden = false
            closestCafeButton.isHidden = false
            messageLabel.text = ""
            
            // Geocode - update the address label
            if let placemark = placemark {
                
                // Conform error - has to be lower case 's' in string
                addressLabel.text = string(from: placemark)
            }
            
            else if performingReverseGeocoding {
                addressLabel.text = "Search for Address..."
            }
            
            else if lastGeocodingError != nil {
                addressLabel.text = "Error Finding Address"
            }
            
            else {
                addressLabel.text = "No Address Found"
            }
            
            // Assign current latitude and longitude to query later
            myLatitude = location.coordinate.latitude
            myLongitude = location.coordinate.longitude
            print("Latitude: \(myLatitude) | Longitude: \(myLongitude)" )
        }
            
        else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
//            tagButton.isHidden = true
            closestCafeButton.isHidden = true
            let statusMessage: String
            
            // If location services are disabled OR there is an error getting location
            if let error = lastLocationError as NSError? {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "Location Services Disabled"
                }
                else {
                    statusMessage = "Error Getting Location"
                }
            }
            
            // If location services is disabled
            else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            }
            
            // If updating location is true
            else if updatingLocation {
                statusMessage = "Searching..."
            }
            
                
            // Otherwise, user has to press "Get My Location"
            else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            
            // Output status message at top
            messageLabel.text = statusMessage
        }
        
        configureGetButton()
    }
    
    // Start Location Manager
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
            
            // Schedule timer object to time out after 10 seconds
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(didTimeOut), userInfo: nil, repeats: false)
        }
    }
    
    // Stop Location Manager if updatingLocation is active (true)
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            
            if let timer = timer {
                // Stop timer from running
                timer.invalidate()
            }
        }
    }
    
    // Configure the 'Get My Location' button to display different title
    func configureGetButton() {
        if updatingLocation {
            getButton.setTitle("Stop", for: .normal)
        }
        
        else {
            getButton.setTitle("Get My Location", for: .normal)
        }
    }
    
    // @Param: CLPlacemark object
    // @Return: String concatenation of placemark object
    func string(from placemark: CLPlacemark) -> String {
        var line1 = ""
        
        // Street level info associated with placemark object
        if let s = placemark.subThoroughfare {
            line1 += s + " "
        }
        
        // Street address associated with placemark object
        if let s = placemark.thoroughfare {
            line1 += s
        }
        
        var line2 = ""
        
        // City associated with placemark object
        if let s = placemark.locality {
            line2 += s + " "
        }
        
        // State or province associated with placemark object
        if let s = placemark.administrativeArea {
            line2 += s + " "
        }
        
        // Zipcode associated with placemark object
        if let s = placemark.postalCode {
            line2 += s
        }
        
        return line1 + "\n" + line2
    }
    
    @objc func didTimeOut() {
        print("*** Time Out")
        if location == nil {
            stopLocationManager()
            lastLocationError = NSError(domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
            updateLabels()
        }
    }
    
    
// MARK: - Views    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
// MARK: - Navigation
    // Prepare for segue - pass information to `CafeDetailViewController`
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CafeLocation" {
            let controller = segue.destination as! CafeDetailViewController
            controller.coordinate = location!.coordinate
            controller.placemark = placemark
        }
    }
}


// MARK: - URLSession Extension

extension DiscoverNewViewController {
    // Asynchronous Call
    func asyncCall() {
        let session = URLSession.shared
        // let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:"\(Key.Routes.gRouteLocation)\(myLatitude),\(myLongitude)\(Key.Routes.gRouteRadiusPlacesKey)\(Key.Google.placesKey)")
        print("URL String: \(urlString)")
        let url = URL(string: urlString)
        
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    self.searchResults = self.parse(data: data)
                    // self.searchResults.sort(by: <)
                    print("Search Results: \(self.searchResults)")
                    
                    // Get name and coordinates from searchResults and throw them in an array
                    for results in self.searchResults {
                        self.cafe.name = results.name!
                        self.cafe.latitude = results.geometry.location.lat
                        self.cafe.longitude = results.geometry.location.lng
                        self.cafe.vicinity = results.vicinity!
                        self.cafesInRange.append(self.cafe)
                        print("Coordinates: \(results.geometry.location.lat), \(results.geometry.location.lng)")
                    }
                                        
                    // Search for the closest cafe to my current location
                    // Update closest location in main thread
                    for cafe in self.cafesInRange {
                        print("All cafes: \(cafe)")
                        self.closestLocationCoordinates = self.findDistance(myLocation: self.myLocation, latitude: self.cafe.latitude, longitude: self.cafe.longitude)
                        if self.minDistance >= self.closestLocationCoordinates {
                            self.minDistance = self.closestLocationCoordinates
                            self.closestCafeName = cafe.name
                            self.closestCafeAddress = cafe.vicinity
                        }
                    }
                    
                    print("Closest Location Coordinates: \(self.closestLocationCoordinates)")
                    
                    // This is the main thread, update label in main thread
                    DispatchQueue.main.async {
                        self.closestCafeLabel.text = self.closestCafeName
                        self.closestCafeAddressLabel.text = self.closestCafeAddress
                    }
                    return
                }
            }
            
            do {
                let json = try JSONDecoder().decode(SearchResult.self, from: data!)
                print(json)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    // Find distance between my current location and all cafes near me
    func findDistance(myLocation: CLLocation, latitude: Double, longitude: Double) -> Double {
        var closestLocation = 0.0
        let currentCafeLocation = CLLocation(latitude: latitude, longitude: longitude)
        var minDistance = 1000000000000000.0
        let distance = myLocation.distance(from: currentCafeLocation)
        if minDistance >= distance {
            minDistance = distance
            closestLocation = distance
        }
        return closestLocation
    }
}
