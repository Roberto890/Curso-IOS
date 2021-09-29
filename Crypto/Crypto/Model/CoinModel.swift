//
//  CoinModel.swift
//  Crypto
//
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
