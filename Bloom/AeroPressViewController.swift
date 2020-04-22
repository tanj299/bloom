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
    var isPaused = false
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
//********************************************************************************
// @IBAction and functions
//********************************************************************************

    @IBAction func start(_ sender: UIButton) {
        // Checks if timer is running; fixes the timer counting down faster
        // Prevents new Timer object from being created on each tap of the button
        if isTimerRunning == false {
            runTimer()
            self.startButton.isEnabled = false
        }
    }
    
    
    // The timerInterval, which is how often the method will be called
    // Selector is an Obj-C method so you must preface the function argument with `@objc`
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButton.isEnabled = true
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        }
        else {
            // Decrement timer countdown by seconds
            seconds -= 1
            // Update the label
            timerLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    @IBAction func pause() {
        if self.isPaused == false {
            // invalidate() stops the timer but does not reset the current value of seconds
            timer.invalidate()
            self.isPaused = true
            
            // pause button should set to "Resume" if Timer is paused
            self.pauseButton.setTitle("Resume", for: .normal)
        }
        
        else {
            runTimer()
            self.isPaused = false
            
            // pause button should set to "Pause" if Timer is running
            self.pauseButton.setTitle("Pause", for: .normal)
//            timer.fire()
        }
    }

    
    @IBAction func reset() {
        timer.invalidate()
        seconds = 60
        timerLabel.text = timeString(time: TimeInterval(seconds))
        
        // Prevent Timer from restarting
        isTimerRunning = false
        pauseButton.isEnabled = false
        startButton.isEnabled = true
        
        // After `reset` is pressed, the pause button should reset to its pause state
        // And if 
        isPaused = false
        pauseButton.setTitle("Pause", for: .normal)
        
    }
    
    // Convert our UILabel to a time string format
    // Format: HH : MM : SS
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 360
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i : %02i : %02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

}
