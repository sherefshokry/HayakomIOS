//
//  Interest.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import Arrow

struct Interest : Codable {
    var id : Int
}
extension Interest : ArrowParsable{
    init() {
        id = -1
    }
    
    mutating func deserialize(_ json: JSON) {
        id <-- json[""]
    }
}
