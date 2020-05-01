//
//  PersistencyHelper.swift
//  Bloom
//
//  Created by Jayson Tan on 5/1/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import Foundation

class PersistencyHelper {
    // Persist data in .plist file for InventoryViewController

    static func saveBeanInventory(_ coffeeInventory: [CoffeeItem]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(coffeeInventory)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        }
        catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    static func loadInventory() -> [CoffeeItem] {
        var inventory = [CoffeeItem]()
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                inventory = try decoder.decode([CoffeeItem].self, from: data)
            }
            catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
        return inventory
    }
    
    static func dataFilePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("CoffeeInventory.plist")
    }
}
