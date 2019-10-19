//
//  BaseResponse.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import Arrow

struct BaseResponse  {
    var Status : Bool
    var Message : String
    var Obj : [String : Any]
}
extension BaseResponse : ArrowParsable{
    init() {
        Status = false
        Message = ""
        Obj = [String : Any]()
    }
    
    mutating func deserialize(_ json: JSON) {
        Status <-- json["Status"]
        Message <-- json["Message"]
        Obj <-- json["Obj"]
    }
    
    init(dict : [String : Any]) {
        self.init()
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
        self.deserialize(JSON.init(decoded)!)
    }
}
