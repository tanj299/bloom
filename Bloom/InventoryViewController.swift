//
//  DiscoverViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class InventoryViewController: UITableViewController {
    
    var beansItem = [CoffeeItem]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Unwind Segues from 'CoffeeDetailViewController' 
    // Cancel button to prevent adding coffees
    @IBAction func cancel(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue){
        // Append the new coffee bean to our array
        // Display it in table view
        let newBeanItem = CoffeeItem()
        let coffeeDetailVC = segue.source as! CoffeeDetailViewController
        newBeanItem.coffeeName = coffeeDetailVC.name
        newBeanItem.dateRoasted = coffeeDetailVC.date
        
        // Add new item to array and reload the data
        beansItem.append(newBeanItem)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = CoffeeItem()
        item1.coffeeName = "Victrola"
        item1.dateRoasted = "2020-04-29"
        
        let item2 = CoffeeItem()
        item2.coffeeName = "Blue Bottle"
        item2.dateRoasted = "2020-02-17"
        beansItem = [item1, item2]
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table View Data Source
    // Table View data source for coffee inventory, including delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beansItem.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeItem", for: indexPath)
        
        let beanItem = beansItem[indexPath.row]
        
        let nameLabel = cell.viewWithTag(101) as! UILabel
        let dateLabel = cell.viewWithTag(102) as! UILabel
        
        nameLabel.text = beanItem.coffeeName
        dateLabel.text = beanItem.dateRoasted
        
//        cell.textLabel?.text = beansItem[indexPath.row].coffeeName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        beansItem.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
