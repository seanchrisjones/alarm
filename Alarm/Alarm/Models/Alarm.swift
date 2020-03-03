//
//  Alarm.swift
//  Alarm
//
//  Created by Sean Jones on 3/2/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable{
    
    var alarmName: String
    var isEnabled: Bool
    var uuid: String = UUID().uuidString
    var date: Date
    var fireTime: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        return dateFormatter.string(from: date)
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    init(alarmName: String, isEnabled: Bool, date: Date){
        self.alarmName = alarmName
        self.isEnabled = isEnabled
        self.date = date
        
        
    }
}
func ==(lhs: Alarm, rhs: Alarm) -> Bool{
  return lhs.date == rhs.date && lhs.alarmName == rhs.alarmName && lhs.isEnabled == rhs.isEnabled && lhs.uuid == rhs.uuid
}

