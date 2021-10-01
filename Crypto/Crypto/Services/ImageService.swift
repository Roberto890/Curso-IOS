//
//  ImageService.swift
//  Crypto
//
//

import UIKit

protocol ImageServiceDelegate {
    func didSucessImage(_ coinManager: ImageService, imagesModel: [ImageModel])
    func didFailedWithError(error: Error)
}

struct ImageService {
    
    var delegate: ImageServiceDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/assets/icons"
    let apiKey = "560BFDF0-815A-4680-BEA4-0D4AD30A19FC"
    
    func getCoinImages(){
        let urlString = "\(baseURL)/%7B20%7D"
        peformRequest(with: urlString)
    }
    
    let criptoCoin = ["BTC","ETH","USDT","ADA","BCH","XRP","LTC","LUNA","DOT","DOGE"]
    
    func peformRequest(with urlString: String) {
        print(urlString)
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
                    if let images = parseJSON(safeData) {
                        self.delegate?.didSucessImage(self, imagesModel: images)
                    }
                }
            }
            task.resume()
        }
        print("eaa")
    }
    
    func parseJSON(_ imageData: Data) -> [ImageModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([ImageData].self, from: imageData)
            var imagesData: [ImageModel] = []
            
            for image in decodedData {
                
                if criptoCoin.contains(image.asset_id) {
                    let urlImage = image.url
                    let criptoType = image.asset_id
                    
                    let imageData = ImageModel(criptoType: criptoType, coinImage: urlImage)
                    imagesData.append(imageData)
                }
            
            }
                
            return imagesData
            
        } catch {
            self.delegate?.didFailedWithError(error: error)
            return nil
        }
    }
    
    func loadImage(urlImage: String, completionHandler: @escaping(UIImage) -> Void) {
        let url = URL(string: urlImage)!
            let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
                if let data = data {
                    completionHandler(UIImage(data: data)!)
                }
            }
        dataTask.resume()
    }
    
}
