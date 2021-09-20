//
//  CalculatorModel.swift
//  Tipsy
//
//  Created by Virtual Machine on 20/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
struct CalculatorModel {
    
    var billModel: BillModel?
    
    mutating func calculateBill(billValue: Double, billPercent: Double, billSplit: Double) {
        let totalBill = (billValue * billPercent) / billSplit
        let persent = Int((billPercent - 1) * 100)
        let message = "Split between \(Int(billSplit)) people, with \(persent)% tip"
        billModel = BillModel(billTotal: totalBill, billMessage: message)
    }
    
    func getBill() -> String {
        if let totalBill = billModel?.billTotal {
            return String(format: "%0.2f", totalBill)
        }
        return ""
    }
    
    func getMessage() -> String{
        if let messageBill = billModel?.billMessage{
            return messageBill
        }
        return ""
    }
}
