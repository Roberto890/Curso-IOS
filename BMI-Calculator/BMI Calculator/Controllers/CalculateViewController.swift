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
    
    var calculatorModel = CalculatorModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func heightSliderChanged(_ sender: UISlider) {
        lblUserHeight.text = "\(String(format: "%.2f", sender.value))m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        lblUserWeight.text = "\(String(format: "%.0f", sender.value))Kg"
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = sldHeight.value
        let weight = sldWeight.value
        
        if height == 0 || weight == 0 {
            let alert = UIAlertController(title: "Alert", message: "Height and Weight can't be zero", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            calculatorModel.calculateBMI(height: height, weight: weight)
            
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorModel.getBMIValue()
            destinationVC.bmiMessage = calculatorModel.getBMIMessage()
            destinationVC.bmiColor = calculatorModel.getBMIColor()
        }
    }
    
}

