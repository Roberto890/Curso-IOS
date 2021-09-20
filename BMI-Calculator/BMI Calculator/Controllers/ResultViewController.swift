//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Virtual Machine on 15/09/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var bmiValue: String?
    var bmiMessage: String?
    var bmiColor: UIColor?
    
    @IBOutlet weak var lblBmi: UILabel!
    @IBOutlet weak var lblAdvice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBmi.text = bmiValue
        lblAdvice.text = bmiMessage
        view.backgroundColor = bmiColor
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
