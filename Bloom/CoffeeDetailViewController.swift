//
//  CoffeeDetailViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 5/1/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class CoffeeDetailViewController: UIViewController {
    
    var nameAddString: String = ""
    var dateAddString: String = ""
    var originAddString: String = ""
    var companyAddString: String = ""
        
    // Coffee Name text field
    @IBOutlet weak var coffeeNameAdd: UITextField!
    @IBOutlet weak var dateRoastedAdd: UITextField!
    @IBOutlet weak var datePickerAdd: UIDatePicker!
    @IBOutlet weak var originAdd: UITextField!
    @IBOutlet weak var companyAdd: UITextField!
    
    // Date Picker object
    @IBAction func datePickerAddChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePickerAdd.date)
        dateRoastedAdd.text = strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeNameAdd.placeholder = "Coffee Name"
        dateRoastedAdd.placeholder = "Date Roasted"
        originAdd.placeholder = "Origin"
        companyAdd.placeholder = "Company"
        
        // Do any additional setup after loading the view.
    }
    
    // Pass information back to InventoryController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            // Pass user input's text in the fields to InventoryVC to save in array
            nameAddString = coffeeNameAdd.text!
            dateAddString = dateRoastedAdd.text!
            originAddString = originAdd.text!
            companyAddString = companyAdd.text!
        }
    }

}
