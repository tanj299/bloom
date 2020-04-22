import UIKit

var str = "Hello, playground"
@IBOutlet weak var timerLabel: UILabel!

// Variable will hold starting value of timer
// Can change to any amount above 0
var seconds = 60
var timer = Timer()

// Ensures that only one timer is created at a time
var isTimerRunning = false

var resumeTapped = false

@IBAction func start(_ sender: UIButton!) {
    runTimer()
}

// Initialize timer
// Specify the timerInterval, which is how often the method will be called
// The select is the method being called; this is an Obj-C method so you must preface the function with `@objc`
func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                 selector: #selector(updateTimer), userInfo: nil, repeats: true)
}

@objc func updateTimer() {
    // Decrement timer countdown by seconds
    seconds -= 1
    
    // Update the label
    timerLabel.text = "\(seconds)"
}

@IBAction func pause(_ sender: UIButton!) {
    if self.resumeTapped == false {
        timer.invalidate()
        self.resumeTapped = true
    }
    
    else {
        runTimer()
        
    }
}

@IBAction func reset(_ sender: UIButton!) {
    timer.invalidate()
    seconds = 60
    timerLabel.text = timeString(time: TimeInterval(seconds))
}

func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 360
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format: "%02i:%2i:%02i", hours, minutes, seconds)
}
