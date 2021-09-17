//
//  CalculateViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet weak var lblUserHeight: UILabel!
    @IBOutlet weak var lblUserWeight: UILabel!
    @IBOutlet weak var sldWeight: UISlider!
    @IBOutlet weak var sldHeight: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        lblUserHeight.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        lblUserWeight.text = "\(Int(sender.value))Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = sldHeight.value
        let weight = sldWeight.value
        
        let bmi = weight/pow(height, 2)
        print(bmi)
    }
}

