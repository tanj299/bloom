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
        
    // Coffee Name text field
    @IBOutlet weak var coffeeName: UITextField!
    @IBOutlet weak var dateRoasted: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        coffeeName.placeholder = "Coffee Name"
        dateRoasted.placeholder = "Date Roasted"
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = coffeeName.text!
            date = dateRoasted.text!
        }
    }

}
