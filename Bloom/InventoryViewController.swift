//
//  DiscoverViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class InventoryViewController: UITableViewController {
    
    var coffeeInventory = [CoffeeItem]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Unwind Segues from 'CoffeeDetailViewController' 
    // Cancel button to prevent adding coffees
    @IBAction func cancel(segue:UIStoryboardSegue) {
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        // Append the new coffee bean to our array
        // Display it in table view
        let newBeanItem = CoffeeItem()
        let coffeeDetailVC = segue.source as! CoffeeDetailViewController
        newBeanItem.coffeeName = coffeeDetailVC.name
        newBeanItem.dateRoasted = coffeeDetailVC.date
        if(newBeanItem.dateRoasted == "") {
            print("It be empty")
        }
        
        // Add new item to array and reload the data
        // Persist data in Inventory.plist, do NOT create a new inventory
        // Use reference of coffeeInventory to persist data
        coffeeInventory = PersistencyHelper.loadInventory()
        coffeeInventory.append(newBeanItem)
        PersistencyHelper.saveBeanInventory(coffeeInventory)
        tableView.reloadData()

        print("current inventory: ", coffeeInventory)
//        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeInventory = PersistencyHelper.loadInventory()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View Data Source
    // Table View data source for coffee inventory, including delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeInventory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeItem", for: indexPath)
        
        let beanItem = coffeeInventory[indexPath.row]
        
        let nameLabel = cell.viewWithTag(101) as! UILabel
        let dateLabel = cell.viewWithTag(102) as! UILabel
        
        nameLabel.text = beanItem.coffeeName
        dateLabel.text = beanItem.dateRoasted
        
//        cell.textLabel?.text = coffeeInventory[indexPath.row].coffeeName
        
        return cell
    }
    
    // Swipe to delete - 632
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        coffeeInventory.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
        
        PersistencyHelper.saveBeanInventory(coffeeInventory)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // didSelectRowAt delegate will segue to full coffee details
//        self.performSegue(withIdentifier: "coffeeDetails", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
