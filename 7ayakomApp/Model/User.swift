//
//  User.swift
//  A3maly
//
//  Created by Nora Sayed on 10/12/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import Arrow

struct  User : Codable {
    var UserId : Int
    var UserName : String
    var gender : String
    var ImagePath : String
    var Email : String
}

extension User : ArrowParsable{
    init() {
        UserId = -1
        UserName = ""
        gender = ""
        ImagePath = ""
        Email = ""
    }
    

    
    mutating func deserialize(_ json: JSON) {
        UserId <-- json["UserId"]
        UserName <-- json["UserName"]
        gender <-- json["Gender"]
        ImagePath <-- json["ImagePath"]
        ImagePath =  ImagePath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        Email <-- json["Email"]
    }
    
    
    init(dict : [String : Any]) {
        self.init()
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
        self.deserialize(JSON.init(decoded)!)
    }
    
    
    static func getList(data: [[String : Any]])->[User]{
        var list = [User]()
        for object in data {
            var event = User()
            let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            event.deserialize(JSON.init(decoded)!)
            list.append(event)
        }
        return list
    }
    
    
}
