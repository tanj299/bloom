//
//  AeroPressViewController.swift
//  Bloom
//
//  Created by Jayson Tan on 4/18/20.
//  Copyright © 2020 Jayson Tan. All rights reserved.
//

import UIKit

class AeroPressViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    // Variable will hold starting value of timer
    // Can change to any amount above 0
    var seconds = 60
    
    var timer = Timer()
    
    // Ensures that only one timer is created at a time
    var isTimerRunning = false
    
    @IBAction func start(_ sender: UIButton) {
        runTimer()
    }
    
    // Initialize timer
    // Specify the timerInterval
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        print("Hi")
    }
    
    @IBAction func pause(_ sender: UIButton) {
    }
    
    @IBAction func reset(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
