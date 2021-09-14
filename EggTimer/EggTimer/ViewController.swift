//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!
    
    var eggTimes = ["Soft": 300.0, "Medium": 450.0, "Hard": 720.0]
    
    var timer = Timer()
    var secondsPassed: Double = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        self.timer.invalidate()
        secondsPassed = 0
        progressBar.progress = 0
        let hardness = sender.currentTitle!
        TimeCounter(maxSeconds: eggTimes[hardness]!)

    }
    
    func TimeCounter(maxSeconds: Double){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [self] (Timer) in
            if secondsPassed < maxSeconds {
                secondsPassed += 1
                let percentageProgress = self.secondsPassed / maxSeconds
                progressBar.progress = Float(percentageProgress)
                lblTime.text = "\(secondsPassed) de \(maxSeconds) segundos"
            }else {
                self.timer.invalidate()
                lblTitle.text = "DONE!"
                let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
            }
        }
    }
}
