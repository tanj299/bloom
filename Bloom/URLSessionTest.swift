//
//  URLSession.swift
//  Bloom
//
//  Created by Jayson Tan on 4/23/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation
import UIKit

class URLSessionTestViewController: UIViewController  {
    
    let hunterLatitude = 40.767962
    let hunterLongitude = -73.964207
    let key = "AIzaSyChSr1L3g4pm6qdREQni1qzNUvPaUU-9yw"
    
    @IBAction func callAPI() {
        let call = apiCall(searchText: "Museum of Contemporary Art Australia")
        print("API Call Results: \(call)")
    }
}

extension URLSessionTestViewController {
    
    func apiCall(searchText: String) -> URL {
        let session = URLSession.shared
        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format:"https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=%@&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=\(key)", encodedText)
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            print(error)
            print(response)
        })
        task.resume()
        return url!
    }
    
//    func returnSession() {
//        let session = URLSession.shared
//        let url = String(format:"https://maps.googleapis.com/maps/api/place/search/json?location=\(hunterLatitude),\(hunterLongitude)&key=\(key)")
//        let task = session.dataTask(with: url, completionHandler: {
//            data, response, error in
//            print(error)
//            print(response)
//        })
//        task.resume()
//    }
}
