//
//  ViewController.swift
//  stopwatch-ios
//
//  Created by Andrea Bizzotto on 17/03/2018.
//  Copyright © 2018 musevisions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    
    var startDate: Date!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDate = Date()
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            
            let elapsed = Date().timeIntervalSince(self.startDate)
            let hundreds = Int((elapsed - trunc(elapsed)) * 100.0)
            let seconds = Int(trunc(elapsed))
            let minutes = seconds / 60
            let hundredsStr = String(format: "%02d", hundreds)
            let secondsStr = String(format: "%02d", seconds)
            let minutesStr = String(format: "%02d", minutes)
            self.timerLabel.text = "\(minutesStr):\(secondsStr).\(hundredsStr)"
        }
    }

    @IBAction func leftButtonPressed(_ sender: Any) {
    
    }
    @IBAction func rightButtonPressed(_ sender: Any) {
    
    }

    
}

