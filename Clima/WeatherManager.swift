//
//  WeatherManager.swift
//  Clima
//
//  Created by Virtual Machine on 21/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d5919a20e36fd218bafeca96865b24a2&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        peformRequest(urlString: urlString)
    }
    
    func peformRequest(urlString: String){
        //1.create url
        if let url = URL(string: urlString){
            //2.crete urlSession
            let session = URLSession(configuration: .default)
            
            //3.give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
            
            //4.start the task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: city, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperatureString)
            
        } catch {
            print(error)
        }
    }
    
}

