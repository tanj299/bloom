//
//  EditCoffeeDetailTableViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 5/2/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

protocol EditCoffeeDetailTableViewControllerDelegate: class {
    func editCoffeeDetailViewControllerDidCancel(_ controller: EditCoffeeDetailTableViewController)
    func editInventoryViewController(_ controller: EditCoffeeDetailTableViewController, didFinishEditing item: CoffeeItem)
}

class EditCoffeeDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var coffeeName: UITextField!
    @IBOutlet weak var dateRoasted: UITextField!
    @IBOutlet weak var origin: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var delegate: EditCoffeeDetailTableViewControllerDelegate?
    var coffeeItem: CoffeeItem!
    
    override func viewDidLoad() {
        // Load the CoffeeItem() object when we pass the information from prepare(for segue) in InventoryVC
        coffeeName.text = coffeeItem.coffeeName
        dateRoasted.text = coffeeItem.dateRoasted
        origin.text = coffeeItem.origin
        company.text = coffeeItem.company
        
        // Placeholder names via code instead of storyboard
        coffeeName.placeholder = "Coffee Name"
        dateRoasted.placeholder = "Date Roasted"
        origin.placeholder = "Origin"
        company.placeholder = "Company"
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        coffeeName.becomeFirstResponder()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateRoasted.text = strDate
    }

    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.editCoffeeDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        print("Contents of the field: \(coffeeName.text!)" )
        
        // Upon pressing done, the message is editInventoryViewController(_: didFinishEditing:)
        // Passes along the CoffeeItem with the text string from their text fields
        coffeeItem.coffeeName = coffeeName.text!
        coffeeItem.dateRoasted = dateRoasted.text!
        coffeeItem.origin = origin.text!
        coffeeItem.company = company.text!
        delegate?.editInventoryViewController(self, didFinishEditing: coffeeItem)
    }
    
    // MARK: - Table view data source
    // Return number of sections available - this is the reason why my tables weren't visible
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return number of static cell rows available - this is the reason why my tables weren't visible
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String) -> Bool {
        let oldText = coffeeName.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        if newText.isEmpty {
            doneButton.isEnabled = false
        }
        else {
            doneButton.isEnabled = true
        }
        return true
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
