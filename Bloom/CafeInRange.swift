//
//  CafeInRange.swift
//  Bloom
//
//  Created by Jayson Tan on 5/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation
import CoreLocation

// We use a struct instead of class since classes are reference type
// In other words, we can't directly append an object to an array 
struct CafeInRange: Codable {
    var name = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
}
