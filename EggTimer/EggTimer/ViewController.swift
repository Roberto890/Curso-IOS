//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let maxSeconds = eggTimes[hardness]!
        switch hardness {
        case "Soft":
            TimeCounter(seconds: maxSeconds)
        case "Medium":
            TimeCounter(seconds: maxSeconds)
        case "Hard":
            TimeCounter(seconds: maxSeconds)
        default:
            print("no one time selected")
        }
    }
    
    func TimeCounter(seconds: Int){
        var secondsRemaining = seconds
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ (Timer) in
            if secondsRemaining > 0{
                print("\(secondsRemaining) seconds")
                secondsRemaining -= 1
            }else {
                Timer.invalidate()
            }
        }
    }
}
