//
//  DiscoverViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class InventoryViewController: UITableViewController, EditCoffeeDetailTableViewControllerDelegate {
    
    var coffeeInventory = [CoffeeItem]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    @IBAction func addNew(_ sender: UIButton) {
//        performSegue(withIdentifier: "addNew", sender: Any?.self)
//    }
//    
    // MARK: - Unwind Segues from 'CoffeeDetailViewController'
    // Cancel button to prevent adding coffees
    @IBAction func cancel(segue:UIStoryboardSegue) {
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        // Append the new coffee bean to our array
        // Display it in table view
        let newBeanItem = CoffeeItem()
        let coffeeDetailVC = segue.source as! CoffeeDetailViewController
        
        newBeanItem.coffeeName = coffeeDetailVC.nameAddString
        newBeanItem.dateRoasted = coffeeDetailVC.dateAddString
        newBeanItem.origin = coffeeDetailVC.originAddString
        newBeanItem.company = coffeeDetailVC.companyAddString
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
        let selectedBean = coffeeInventory[indexPath.row]
        
        print("Selected Bean: ", selectedBean.coffeeName)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Edit Coffee Detail ViewController Delegates
    func editCoffeeDetailViewControllerDidCancel(_ controller: EditCoffeeDetailTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func editInventoryViewController(_ controller: EditCoffeeDetailTableViewController, didFinishEditing item: CoffeeItem) {
        if let index = coffeeInventory.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            let indexPaths = [indexPath]
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
        
        // Save updated coffee inventory with PersistencyHelper
        PersistencyHelper.saveBeanInventory(coffeeInventory)
        navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Find the new view controller via segue.destination
        // The bang (!) operator is a force downcast to cast an object of one type to a different type
        // Segues to edit coffee 
        if segue.identifier == "editSegue" {
            let controller = segue.destination as! EditCoffeeDetailTableViewController
        
            // Set delegate property to self, referrring to InventoryViewController
            controller.delegate = self
            
            // Reference the table cell being tapped on and find the index path using tableView.indexPath(for:)
            // This is the unwrap that needs to be done to avoid nil returns
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.coffeeItem = coffeeInventory[indexPath.row]
            }
        }
    }
    
}
