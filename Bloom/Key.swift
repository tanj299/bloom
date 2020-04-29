//
//  Key.swift
//  Bloom
//
//  Created by Jayson Tan on 4/28/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation

struct Key {
    static let DeviceType = "iOS"
    
    struct Google {
        static let placesKey = "AIzaSyChSr1L3g4pm6qdREQni1qzNUvPaUU-9yw"
    }
    
    struct Routes {
        static let gRoutePlaces = "https://maps.googleapis.com/maps/api/place/search/output?parameters"
        static let gRouteSample = "https://maps.googleapis.com/maps/api/place/search/json?location=-33.8670522,151.1957362&radius=500&types=food&sensor=true&key=AddYourOwnKeyHere"
    }
}
