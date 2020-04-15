//
//  FirstViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/9/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//  SN: Student Notes - Intended for learning and note taking; do not take into consideration when reviewing


//  SN: To allow ScrollView to work, every field must be constrained or simulator won't work
//  SN: This applies to ScrollView and TextView
//  SN: @IBAction: Work to happen when you use the element (ie. hit a button)
//  SB: @IBOutlet: Manipulate the element (ie. change its title, rounds it corners, etc.)
//

import UIKit

class BrewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func brewTest() {
        print("You are in Brew Controller")
    }
    
// MARK: - Immersion
    
    @IBAction func aeroPress() {
        print("AeroPress button")
    }
    
    @IBAction func frenchPress() {
        print("French Press button")
    }
    
    @IBAction func coldBrew() {
        print("Cold Brew button")
    }
    
    
// MARK: - Percolation
    
    @IBAction func harioV60() {
        print("Hario V60 button")
    }
    
    @IBAction func kalitaWave() {
        print("Kalita Wave button")
    }
    
    @IBAction func chemex() {
        print("Chemex button")
    }
    
    @IBAction func bodum() {
        print("Bodum button")
    }

    @IBAction func manualPourOver() {
        print("Manual Pour Over button")
    }
 
// MARK: - Siphon
    
    @IBAction func harioTechnica() {
        print("Hario Technica button")
    }
    
    @IBAction func yamaGlass() {
        print("Yama Glass button")
    }
    
    @IBAction func bodumSantos() {
        print("Bodum Santos button")
    }
    
// MARK: - Miscellaneous
    
    @IBAction func espresso() {
        print("Espresso button")
    }
    
    @IBAction func mokaPot() {
        print("Moka Pot button")
    }
    
    @IBAction func phin() {
        print("Phin button")
    }
    
}

