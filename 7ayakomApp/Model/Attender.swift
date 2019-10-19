//
//  Attender.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/11/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import Foundation
import  Arrow


struct Attender : Codable {
    var userId : Int
    var fullName : String
    var userName : String
    var imagePath : String
   
}

extension Attender : ArrowParsable{
    init() {
    userId = 0
    fullName = ""
    userName = ""
    imagePath = ""
    }
    
    mutating func deserialize(_ json: JSON) {
        userId <-- json["UserId"]
        fullName <-- json["FullName"]
        userName <-- json["UserName"]
        imagePath <-- json["ImagePath"]
  
    }
    
    static func getList(data: [[String : Any]])->[Attender]{
        var list = [Attender]()
        for object in data {
            var attender = Attender()
            let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
           attender.deserialize(JSON.init(decoded)!)
            list.append(attender)
        }
        return list
    }
}
