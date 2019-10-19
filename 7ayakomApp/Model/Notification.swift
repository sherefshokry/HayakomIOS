//
//  Notification.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/18/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//


import Foundation
import  Arrow

struct UserNotificaton : Codable {
    var id : Int
    var userId : Int
    var userName : String
    var isIOS : Bool
    var meetUpId : Int
    var meetUpName : String
    var notificationTypeId : Int
    var notificationTypeName : String
    var notificationText : String
    var notificationDate : String
    
}

extension UserNotificaton : ArrowParsable{
    init() {
     id = -1
     userId = -1
     userName = ""
     isIOS = true
     meetUpId = 0
     meetUpName = ""
     notificationTypeId = 0
     notificationTypeName = ""
     notificationText = ""
    notificationDate = ""
    }
    
    mutating func deserialize(_ json: JSON) {
       id <-- json["NotificationDetailsId"]
       userId <-- json["UserId"]
       userName <-- json["UserFullName"]
       isIOS <-- json["IsIOS"]
       meetUpId <-- json["MeetupId"]
       meetUpName <-- json["MeetupName"]
       notificationTypeId <-- json["NotificationTypeId"]
       notificationTypeName <-- json["NotificationTypeName"]
       notificationText <-- json["NotificationText"]
        notificationDate <-- json["NotificationDate"]
    }
    
    static func getList(data: [[String : Any]])->[UserNotificaton]{
        var list = [UserNotificaton]()
        for object in data {
            var event = UserNotificaton()
            let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            event.deserialize(JSON.init(decoded)!)
            list.append(event)
        }
        return list
    }
    
    init(dict : [String : Any]) {
          self.init()
          let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
          let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
          self.deserialize(JSON.init(decoded)!)
      }
      
      
    
}
