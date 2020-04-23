//
//  URLSession.swift
//  Bloom
//
//  Created by Jayson Tan on 4/23/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation

// .shared used to create a singleton object
// URLSession.shared is a singleton reference to a URLSession instance with no configuration
let session = URLSession.shared
let url = URL(string: "https://learnappmaking.com/ex/users.json")!
