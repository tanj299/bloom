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
        static let gRouteLocation = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
        static let gRouteRadius = "&radius="
        static let gRoutePlaceType = "&type=cafe&key="
    }
}
