//
//  Message.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/16/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import Foundation
import  Arrow


struct LastMessage : Codable {
    var lastMessage : String
    var lastMessageDate : String
    var user : User

}

extension LastMessage : ArrowParsable{
        init() {
        lastMessage = ""
        lastMessageDate = ""
        user = User()
        }
        
        mutating func deserialize(_ json: JSON) {
           lastMessage <-- json["lastMsg"]
           lastMessageDate <-- json["lastMsgDate"]
           user <-- json["receiverUser"]
        }
        
        init(dict : [String : Any]) {
            self.init()
            let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            self.deserialize(JSON.init(decoded)!)
        }
  }




