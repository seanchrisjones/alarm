//
//  AlarmController.swift
//  Alarm
//
//  Created by Sean Jones on 3/2/20.
//  Copyright © 2020 Sean Jones. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmSchedulerDelegate : class{
    //func scheduleUserNotifications(for alarm: Alarm)
    //func  cancelUserNotifications( for alarm: Alarm)
    
}
extension AlarmSchedulerDelegate {
    
   func scheduleUserNotification(for alarm: Alarm){
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "body"
        content.sound = UNNotificationSound.default
    let dateComponents = Calendar.current.dateComponents([.hour,.minute], from: alarm.date)
    let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let notificationRequest = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: calendarTrigger)
    UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil)
}
    
    
    
    func cancelUserNotifications(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
        
    }
}
   

class AlarmController : AlarmSchedulerDelegate {
    
    static var sharedInstance = AlarmController()
    var alarms: [Alarm] = []
//    var alarms: [Alarm]{
//        let breakfastTime = Date(timeInterval: 0.60, since: Date())
//        let breakfast = Alarm(alarmName: "Breakfast", isEnabled: true, date: breakfastTime )
//        let lunch = Alarm(alarmName: "Lunch", isEnabled: true, date: breakfastTime )
//        let dinner = Alarm(alarmName: "Dinner", isEnabled: true, date: breakfastTime)
//
//        return [breakfast, lunch, dinner]
//    }
    
    init(){
           
           loadFromPersistentStore()
       }
    
    
    //MARK: CRUD FUNCTIONS
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let alarm = Alarm(alarmName: name, isEnabled: enabled, date: fireDate)
        alarms.append(alarm)
        scheduleUserNotification(for: alarm)
        saveToPersistentStore()
        
        
        }
    
    func Update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool){
        alarm.alarmName = name
        alarm.date = fireDate
        scheduleUserNotification(for: alarm)
        alarm.isEnabled = enabled
       
        }
    
    func delete(alarm: Alarm){
        if let index = alarms.firstIndex(of: alarm){
        self.alarms.remove(at: index)
            cancelUserNotifications(for: alarm)
            saveToPersistentStore()
        }
}
          func toggleIsON(for alarm: Alarm){
            if alarm.isEnabled{
                scheduleUserNotification(for: alarm)
                
            }
            else{cancelUserNotifications(for: alarm)}
        
        
    }
    
    //MARK: HELPER FUNCTIONS
    
   
    
    //MARK: PERSISTENCE
       
       
       func fileURL() -> URL{
           
           let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           let documentDirectory = paths[0]
           let filename = "alarms32.json"
           let fullURL = documentDirectory.appendingPathComponent(filename)
           
           return fullURL
       }
       
       
       func saveToPersistentStore(){
           
           let encoder = JSONEncoder()
           do{
               let data = try encoder.encode(alarms)
               try data.write(to:fileURL())
               
           }
           catch let error{print(error.localizedDescription)}
           
       }
       
       func loadFromPersistentStore(){
           
           let decoder = JSONDecoder()
           do{
               
               let data = try Data(contentsOf: fileURL())
               let alarms = try decoder.decode([Alarm].self, from:data)
               self.alarms = alarms
           }
           
           catch let error{print(error.localizedDescription)}
           
}
}

