//
//  WeatherViewModel.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 14/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation

class WeatherViewModel {

    var weatherRoot:WeatherRoot?
    var weatherDataOnUIs = [WeatherDataOnUI]()
    
    
    //MARK: - Init
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.weatherDataCame(_:)), name: NSNotification.Name(rawValue: "WeatherDataCame"), object: nil)
        
    }
    
    // handle notification
    @objc func weatherDataCame(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
        
        if let dict = notification.userInfo as NSDictionary? {
            if let _weatherRoot = dict["data"] as? WeatherRoot{
                
                self.weatherRoot = _weatherRoot
                self.buildUIData()
            }
        }
    }
    
    //MARK: - Private
    private func buildUIData(){
        
        if let list = self.weatherRoot?.list, list.count>0{
            
            weatherDataOnUIs.removeAll()
            
            for value in list {
                if let date = value.dt_txt?.getDate(){
                    if date.getHour() == 16{
                        
                        var iconCode:String?
                        var mainDescription:String?
                        
                        if let weather = value.weather, weather.count>0{
                            mainDescription = weather[0].main
                            iconCode = weather[0].icon
                        }
                        
                        weatherDataOnUIs.append(WeatherDataOnUI(day:date.getDayOfWeek(),mainDescription: mainDescription, temp:value.main?.temp?.fromKelvinToCelsius(), iconCode:iconCode) )
                    }
                }
            }
        }
        //  we finish to fetch an to parse data, now we notify the UI to updating itself
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil, userInfo: nil)
    }

    
}
