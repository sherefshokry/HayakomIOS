//
//  Message.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/16/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import Foundation
import  Arrow


struct Message : Codable {
    var message : String
    var messageDate : String
    var user : User

}

extension Message : ArrowParsable{
        init() {
        message = ""
        messageDate = ""
        user = User()
        }
        
        mutating func deserialize(_ json: JSON) {
           message <-- json["messageText"]
           messageDate <-- json["messageTime"]
           user <-- json["senderUser"]
        }
        
        init(dict : [String : Any]) {
            self.init()
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            self.deserialize(JSON.init(decoded)!)
        }
  }




