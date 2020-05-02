//
//  CoffeeDetailViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 5/1/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class CoffeeDetailViewController: UIViewController {
    
    var name: String = ""
    var date: String = ""
    var origin: String = ""
    var company: String = ""
        
    // Coffee Name text field
    @IBOutlet weak var coffeeName: UITextField!
    @IBOutlet weak var dateRoasted: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var originField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    
    // Date Picker object
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateRoasted.text = strDate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeName.placeholder = "Coffee Name"
        dateRoasted.placeholder = "Date Roasted"
        originField.placeholder = "Origin"
        companyField.placeholder = "Company"
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            // Pass user input's text in the fields to InventoryVC to save in array
            // Unwrap optional 
            name = coffeeName.text!
            date = dateRoasted.text!
            origin = originField.text!
            company = companyField.text!
        }
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return true
//    }

}
