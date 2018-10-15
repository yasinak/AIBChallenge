//
//  String.swift
//  AIBChallenge
//
//  Created by Yasin Akinci on 15/10/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation

extension String{
    
    func getDate()->Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        return dateFormatter.date(from: self)
    }
}
