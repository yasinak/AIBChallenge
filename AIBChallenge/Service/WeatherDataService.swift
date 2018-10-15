//
//  WeatherDataService.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 14/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation
import Alamofire


class WeatherDataService{
    
    private let HOST = "https://samples.openweathermap.org"
    private let SERVICE = "/data/2.5/forecast?"
    private let LOCATION_PARAM = "q="
    private let APPID_PARAM = "&appid="
    private let location = "London,uk"
    private let appid = "0d7db3b5be75f90a0250f6d49be7c837"
    private var url: String{
        get{
            return HOST+SERVICE+LOCATION_PARAM+location+APPID_PARAM+appid
        }
    }
    private let iconUrlPart1 = "http://openweathermap.org/img/w/"
    private let iconUrlPart2 = ".png"
    
    //MARK: - Methods to fetch Data from the webservice
    func fetchWeatherData() {

        Alamofire.request(self.url).responseData { response in
            
            if let json = response.result.value {
                do {
                    let weatherRoot = try JSONDecoder().decode(WeatherRoot.self, from: json)
                    
                    let weatherDataDict:[String: WeatherRoot] = ["data": weatherRoot]

                    //  we get the data from the webservivce, now we notify the viewModel to prepare the data
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "WeatherDataCame"), object: nil, userInfo: weatherDataDict)
                }
                catch {
                }
            }
        }

    }
    
    func getIconURL(code:String)->String{
        
        return iconUrlPart1+code+iconUrlPart2
    }
    
    
}
