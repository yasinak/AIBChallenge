//
//  Date.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 15/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation

let weekday = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

extension Date{
    
    func getHour()->Int{
        
        return Calendar.current.component(.hour, from: self)
    }
    func getDayOfWeek()->String{
        
        return weekday[Calendar.current.component(.weekday, from: self)]
    }
}
