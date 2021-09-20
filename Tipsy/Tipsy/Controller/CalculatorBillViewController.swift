//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblBillValue: UITextField!
    @IBOutlet weak var btnZeroPct: UIButton!
    @IBOutlet weak var btnTenPct: UIButton!
    @IBOutlet weak var btnTwentyPct: UIButton!
    @IBOutlet weak var lblSplitNumber: UILabel!
    
    var calculatorModel = CalculatorModel()
    var billModel: BillModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        btnZeroPct.isSelected = false
        btnTenPct.isSelected = false
        btnTwentyPct.isSelected = false
        if sender == btnZeroPct {
            sender.isSelected = true
        }else if sender == btnTenPct {
            sender.isSelected = true
        }else{
            sender.isSelected = true
        }
        lblBillValue.endEditing(true)
    }
    
    @IBAction func btnCalculate(_ sender: UIButton) {
        var tipPercent = 0.0
        if btnZeroPct.isSelected == true{
            tipPercent = 1.0
        }else if btnTenPct.isSelected == true{
            tipPercent = 1.1
        }else if btnTwentyPct.isSelected == true{
            tipPercent = 1.2
        }
        if let bill = lblBillValue.text {
            if let spltNumber = lblSplitNumber.text{
                let bill = Double(bill) ?? 0.0
                let splitNumber = Double(spltNumber) ?? 0.0
                calculatorModel.calculateBill(billValue: bill, billPercent: tipPercent, billSplit: splitNumber)
                self.performSegue(withIdentifier: "resultSegue", sender: self)
            }
        }
    }
    
    @IBAction func stpChanged(_ sender: UIStepper) {
        let stpValue = sender.value
        lblBillValue.endEditing(true)
        lblSplitNumber.text = String(format: "%0.0f", stpValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.billValue = calculatorModel.getBill()
            destinationVC.billMessage = calculatorModel.getMessage()
        }
    }
    
    
}

