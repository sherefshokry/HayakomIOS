//
//  UserDataSource.swift
//  A3maly
//
//  Created by Nora Sayed on 10/4/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import UIKit

class UserDataSource : BaseAPI{
    
    func login(userName : String , userPassword : String , completion:@escaping(ResponseStatus,Any)->Void) {
        
        let url = Constants.LOGIN + "?Username=" + userName + "&Password=" + userPassword
        BaseAPI(url: url  , method: .get , params: nil , headers: nil) { (json, error) in
            if json != nil {
                let status = json!["Status"] as? Bool ?? false
//                let sucess = (errorCode == 0)
                if status{
//                    completion(.sucess , "" )
                    if let data = json!["Obj"] as? [String : Any]{
                        // get user
                        let mUser = User.init(dict: data)
                        UserDataSource.setUser(user: mUser)
                        completion(.sucess , mUser )
                    }else{
                        completion(.networkError , "Something went wrong!".localize())
                    }
                }else{
                    //get error
                    if let error = json![self.errorKey] as? String{
                        completion(.error , error)
                    }else{
                        completion(.networkError , "Something went wrong!".localize())
                    }
                }
            }else{
                if (error != nil){
                    completion(.networkError , error!.localizedDescription)
                }
                else{
                    completion(.networkError,"Something went wrong!")
                }
            }
        }
        
    }
    
  
    
    static func setUser(user: User?) {
        if let value = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(value, forKey: "user")
            
        }else {
            UserDefaults.standard.set(nil, forKey: "user")
            
        }
    }
    
    static func getUser()->User?{
        if let value = UserDefaults.standard.value(forKey: "user") as? Data{
            if let user = try? JSONDecoder().decode(User.self , from: value){
                return user
            }
        }
        return nil
    }
    
    static func setLastChickin(lastUpdate : Date?){
        UserDefaults.standard.set(lastUpdate, forKey: "LastUpdate")
    }
    
    static func getLastChickin()->Date?{
        if let last = UserDefaults.standard.value(forKey: "LastUpdate") as? Date{
            return last
        }
        return nil
    }
    
    static func isCheckedIn()->Bool{
        if let lastCheckIn = getLastChickin() {
            return lastCheckIn.isInSameDay(date: Date())
        }
        return false
    }
    
    static func setUserToken(token : String){
        UserDefaults.standard.set(token, forKey: "UserToken")
    }
    
    static func getUserToken()->String{
        if let last = UserDefaults.standard.value(forKey: "UserToken") as? String{
            return last
        }
        return ""
    }
    
}
