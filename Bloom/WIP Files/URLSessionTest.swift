//
//  URLSession.swift
//  Bloom
//
//  Created by Jayson Tan on 4/23/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

// https://stackoverflow.com/questions/33304340/how-to-find-out-distance-between-coordinates

// Sample Query for 'Museum of Contemporary Art Australia'
// https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Museum%20of%20Contemporary%20Art%20Australia&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=AIzaSyChSr1L3g4pm6qdREQni1qzNUvPaUU-9yw

class URLSessionTestViewController: UIViewController  {
    
    let hunterLatitude:Double = 40.767962
    let hunterLongitude: Double = -73.964572
    let key = "AIzaSyChSr1L3g4pm6qdREQni1qzNUvPaUU-9yw"
    var searchResults = [SearchResult]()
    var cafesInRange = [CafeInRange]()
    var cafe = CafeInRange()
    var closestLocationCoordinates = 0.0
    var minDistance = 100000000000.0
    var closestCafeName = ""
    
    // Use lazy var because this property cannot be accessed until after a `self` is initialized
    lazy var myLocation = CLLocation(latitude: hunterLatitude, longitude: hunterLongitude)
    
    @IBOutlet weak var closestCafeLabel: UILabel!
    
    @IBAction func callAPI() {
        asyncCall()
    }
    
    // Can call API
    // @Return: JSON string
    @IBAction func googlePlacesCall() {
        testCall()
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
}

extension URLSessionTestViewController {
    
    // Asynchronous Call
    func asyncCall() {
        let session = URLSession.shared
        // let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(hunterLatitude),\(hunterLongitude)&radius=200&type=cafe&key=\(key)")
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
                        }
                    }
                    
                    print("Closest Location Coordinates: \(self.closestLocationCoordinates)")
                    
                    // This is the main thread, update label in main thread
                    DispatchQueue.main.async {
                        self.closestCafeLabel.text = self.closestCafeName
                    // self.isLoading = false
                    // self.tableView.reloadData()
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
        // return url!
    }
    
    // Synchronous Call
    func testCall() {
        let mountain = "Museum of Contemporary Art Australia"
        let encodedText = mountain.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(hunterLatitude),\(hunterLongitude)&radius=200&type=cafe&key=\(key)", encodedText)
        let url = URL(string: urlString)

        // Data version
        if let data = testReqData(with: url!) {
            let results = parse(data: data)
            
            // Get Coordinates in loop
            for results in results {
                print("Coordinates: \(results.geometry.location.lat), \(results.geometry.location.lng)")
            }
            print("Got results: \(results)")
        }
    }
    
    // Analagous to "performStoreRequest"
    // For use with `googlePlacesCall`
    func testReq(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        }
        catch {
            print("Error \(error.localizedDescription)")
            return nil
        }
    }
    
    // Analagous to "performStoreRequest"
    // Returns `Data` type instead of string
    func testReqData(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        }
        catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
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
