//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Virtual Machine on 22/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    
    let criptoType: String
    let coinCurrency: String
    let coinValue: Double
    
    var coinValueFormated: String {
        return String(format: "%.2f", coinValue)
    }
    
}
