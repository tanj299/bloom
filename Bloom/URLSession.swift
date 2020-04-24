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
//let session = URLSession.shared
//let url = URL(string: "https://learnappmaking.com/ex/users.json")!
//
//// Assign return value to the `task` constant
//let task = session.dataTask(with: url) { data, response, error, in
//    print(data)
//    print(reponse)
//    print(error)
//})


let session = URLSession.shared
let url = URL(string: "https://learnappmaking.com/ex/users.json")!

let task = session.dataTask(with: url) { data, response, error in

    if error != nil || data == nil {
        print("Client error!")
        return
    }

    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        print("Server error!")
        return
    }

    guard let mime = response.mimeType, mime == "application/json" else {
        print("Wrong MIME type!")
        return
    }

    do {
        let json = try JSONSerialization.jsonObject(with: data!, options: [])
        print(json)
    } catch {
        print("JSON error: \(error.localizedDescription)")
    }
}

