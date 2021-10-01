//
//  CoinViewController.swift
//  Crypto
//

import UIKit

class CoinViewController: UIViewController {
    
    @IBOutlet weak var lblCriptoName: UILabel!
    @IBOutlet weak var lblCriptoValue: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var imgCoin: UIImageView!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    let imageManager = ImageService()
    var coinManager = CriptoService()
    var coinValues: ImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        
        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
        
        criptoLoad(imageModel: coinValues)
        
        
    }
    
    func criptoLoad(imageModel: ImageModel?) {
        if let criptoName = coinValues?.criptoType, let criptoUrl = coinValues?.coinImage {
            lblCriptoName.text = criptoName
            coinManager.getCoinPrice(for: "USD", and: criptoName)
            imageManager.loadImage(urlImage: criptoUrl) { result in
                DispatchQueue.main.async {
                    self.imgCoin.image = result
                }
            }
        }
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
        lblCurrency.text = currency
        coinManager.getCoinPrice(for: currency, and: coinValues!.criptoType)
    }
    
}

//MARK:- CoinManagerDelegate
extension CoinViewController: CriptoServiceDelegate {
    func didSucessCoin(_ coinManager: CriptoService, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.lblCurrency.text = coinModel.coinCurrency
            self.lblCriptoValue.text = coinModel.coinValueFormated
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
}



