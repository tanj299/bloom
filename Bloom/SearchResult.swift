//
//  Properties.swift
//  Bloom
//
//  Created by Jayson Tan on 5/8/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//


// To parse data, structure your class such that it reflects the JSON object you want to parse
import Foundation

class ResultArray: Codable{
    var status: String
    var results = [SearchResult]()
}

class SearchResult: Codable, CustomStringConvertible {
    var geometry = GeometryResults()
    var name: String? = ""
    var vicinity: String? = ""
    
    // Protocol Description property
    // Used with CustomStringConvertible
    var description: String {
        return "Name: \(name ?? "None")"
    }
    
    var address: String {
        return "Vicinity: \(vicinity ?? "None")"
    }
    
    // Gets the value from the exact key of the JSON object
    enum CodingKeys: String, CodingKey {
        case name
        case geometry
        case vicinity
    }
    
}

class GeometryResults: Codable {
    var location = LocationResults()
}

class LocationResults: Codable {
    var lat: Double = 0.0
    var lng: Double = 0.0

}


