//
//  WeatherService.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 11/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class WeatherDataService{
    
    private let HOST = "http://api.openweathermap.org"
    private let SERVICE = "/data/2.5/weather?"
    private let LOCATION_PARAM = "q="
    private let APPID_PARAM = "&appid="
    
    private let location = "London,uk"
    private let appid = "0d7db3b5be75f90a0250f6d49be7c837"
    
    private var url: String{
        get{
            return HOST+SERVICE+LOCATION_PARAM+location+APPID_PARAM+appid
        }
    }
    
    
    func fetchWeatherData() -> Observable<WeatherRoot> {

        //  ici, on crée un Observable (objet qui enoie des données)
        //  Observable<WeatherRoot>.create et on envoie soit :
        //  -   observer.onError
        //  -   observer.onNext avec observer.onCompleted()
        let observable = Observable<WeatherRoot>.create { [weak self] observer in
            if let _self = self {
                let time = 10.0

                //  on push des events à chaque
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {

                    
                    _self.fetchWeatherData()
                    
                    
//                    observer.onError(NSError(domain: "Fake network error", code: 0, userInfo: nil))
//                    observer.onNext(_self.createRandomMatchData())
//                    observer.onCompleted()
                }
            }

            return Disposables.create()
        }
        return observable.share(replay: 1, scope: .forever)
        //return observable.shareReplay(1)
    }
    
    
    func fetchWeatherData(){
        
        Alamofire.request(url).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    
    
}
