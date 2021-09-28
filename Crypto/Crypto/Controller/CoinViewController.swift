//
//  CoinViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CoinViewController: UIViewController {
    
    @IBOutlet weak var lblCriptoValue: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        
        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
        
        coinManager.getCoinPrice(for: "USD")
    }
}

//MARK:- UIPickerViewDataSource and Delegate
extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
    
}

//MARK:- CoinManagerDelegate
extension CoinViewController: CoinManagerDelegate {
    func didSucessCoin(_ coinManager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.lblCurrency.text = coinModel.coinCurrency
            self.lblCriptoValue.text = coinModel.coinValueFormated
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
}



