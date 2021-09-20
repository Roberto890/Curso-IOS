//
//  CalculatorModel.swift
//  BMI Calculator
//
//  Created by Virtual Machine on 20/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorModel {
    
    var bmi: BMIModel?
    
    mutating func calculateBMI(height: Float, weight: Float){
        let bmiValue = weight/pow(height, 2)
        var message: String?
        var color: UIColor?
        switch true {
        case bmiValue < 18.5:
            message = "Underweight"
            color = UIColor.blue
        case bmiValue < 25:
            message = "Normal Weight"
            color = UIColor.green
        case bmiValue < 29.9:
            message = "Overweight"
            color = UIColor.yellow
        case bmiValue < 39.9:
            message = "Obese"
            color = UIColor.orange
        case bmiValue >= 39.9:
            message = "Extremely Obese"
            color = UIColor.red
        default:
            print("error on switch")
        }
        bmi = BMIModel(value: bmiValue, message: message!, color: color!)
    }
    
    func getBMIValue() -> String{
        
        let bmiValue = String(format: "%.1f", bmi!.value)
        return bmiValue
    }
    
    func getBMIMessage() -> String{
        return bmi?.message ?? "error in message try again"
    }
    
    func getBMIColor() -> UIColor{
        return bmi?.color ?? UIColor.white
    }
    
}
