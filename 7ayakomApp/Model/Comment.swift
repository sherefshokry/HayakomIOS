//
//  Comment.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/11/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import Foundation
import  Arrow

struct Comment : Codable {
    var meetupCommentId : Int
    var userId : Int
    var meetupId : Int
    var commentText : String
    var commentDate : String
    var commentUser : Attender
}

extension Comment : ArrowParsable{
    init() {
        meetupCommentId = 0
        userId = 0
        meetupId = 0
        commentText = ""
        commentDate = ""
        commentUser = Attender()
    }
    
    mutating func deserialize(_ json: JSON) {
       meetupCommentId <-- json["MeetupCommentId"]
       userId <-- json["UserId"]
       meetupId <-- json["MeetupId"]
       commentText <-- json["CommentText"]
       commentDate <-- json["CommentDate"]
       commentUser <-- json["MobileUser"]
    }
    
    static func getList(data: [[String : Any]])->[Comment]{
        var list = [Comment]()
        for object in data {
            var event = Comment()
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
