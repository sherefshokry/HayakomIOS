//
//  Category.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import Arrow

struct Category :   Codable{
    var CategoryId : Int
    var CategoryName : String
    var CategoryDescription : String
    var CategoryImagePath : String
    var IsActive : Bool
    var IsFavourite : Bool
}

extension Category : ArrowParsable{
    init() {
        CategoryId = -1
        CategoryName = ""
        CategoryDescription = ""
        CategoryImagePath = ""
        IsActive = false
        IsFavourite = false
    }
    
    mutating func deserialize(_ json: JSON) {
        CategoryId <-- json["CategoryId"]
        CategoryName <-- json["CategoryName"]
        CategoryDescription <-- json["CategoryDescription"]
        CategoryImagePath <-- json["CategoryImagePath"]
        IsActive <-- json["IsActive"]
        IsFavourite <-- json["IsFavourite"]
    }
    
    static func getList(data: [[String : Any]])->[Category]{
        var list = [Category]()
        for object in data {
            var category = Category()
            let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            let decoded = try? JSONSerialization.jsonObject(with: jsonData!, options: [])
            category.deserialize(JSON.init(decoded)!)
            list.append(category)
        }
        return list
    }
}
