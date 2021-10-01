//
//  CriptoService.swift
//  Crypto
//
//

import Foundation

protocol CriptoServiceDelegate {
    func didSucessCoin(_ coinManager: CriptoService, coinModel: CoinModel)
    func didFailedWithError(error: Error)
}

struct CriptoService {
    
    var delegate: CriptoServiceDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "560BFDF0-815A-4680-BEA4-0D4AD30A19FC"
    
    func getCoinPrice(for currency: String, and cripto: String){
        let urlString = "\(baseURL)/\(cripto)/\(currency)"
        print(cripto, currency)
        print(urlString)
        peformRequest(with: urlString)
    }
    
    let criptoCoin = ["BTC","ETH","USDT","ADA","BNB","XRP","SOL","USDC","DOT","DOGE"]
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func peformRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            var session = URLRequest(url: url)
            session.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            session.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: session) { data, response, error in
                if error != nil {
                    delegate?.didFailedWithError(error: error!)
                    return
                }
                
                if response != nil {
                    let apiResponse = response as! HTTPURLResponse
                    print(apiResponse.statusCode)
                }
                
                if let safeData = data {
                    if let coin = parseJSON(safeData) {
                        self.delegate?.didSucessCoin(self, coinModel: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: weatherData)
            //            let time = decodedData.time
            let criptoType = decodedData.asset_id_base
            let currency = decodedData.asset_id_quote
            let value = decodedData.rate
            
            
            let cripto = CoinModel(criptoType: criptoType, coinCurrency: currency, coinValue: value)
            
            return cripto
            
        } catch {
            self.delegate?.didFailedWithError(error: error)
            return nil
        }
    }
    
}
