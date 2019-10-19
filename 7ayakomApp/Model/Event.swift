//
//  Event.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import  Arrow

struct Event : Codable {
    var MeetupId : Int
    var MeetupName : String
    var MeetupDate : String
    var MeetupTime : String
    var MeetupFullLocation : String
    var MeetupLongitude : String
    var MeetupLatitude : String
    var MeetupImagePath : String
    var MeetupDetails : String
    var attenders : Int
    var meetupAttenderUsers : [Attender]
}

extension Event : ArrowParsable{
    init() {
        MeetupId = -1
        MeetupName = ""
        MeetupDate = ""
        MeetupTime = ""
        MeetupFullLocation = ""
        MeetupLongitude = ""
        MeetupLatitude = ""
        MeetupImagePath = ""
        MeetupDetails = ""
        attenders = 0
        meetupAttenderUsers = []
    }
    
    mutating func deserialize(_ json: JSON) {
        MeetupId <-- json["MeetupId"]
        MeetupName <-- json["MeetupName"]
        MeetupDate <-- json["MeetupDate"]
        MeetupTime <-- json["MeetupTime"]
        MeetupFullLocation <-- json["MeetupFullLocation"]
        MeetupLongitude <-- json["MeetupLongitude"]
        MeetupLatitude <-- json["MeetupLatitude"]
        MeetupImagePath <-- json["MeetupImagePath"]
        MeetupDetails <-- json["MeetupDetails"]
        attenders <-- json["Attenders"]
        meetupAttenderUsers <-- json["MeetupAttenderUsers"]
    }
    
    static func getList(data: [[String : Any]])->[Event]{
        var list = [Event]()
        for object in data {
            var event = Event()
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
