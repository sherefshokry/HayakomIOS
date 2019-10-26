//
//  EventDataSource.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation

class EventDataSource: BaseAPI {

    
    func getAllMeetUps(completion:@escaping(ResponseStatus,Any)->Void) {
        
        BaseAPI(url: Constants.GET_ALL_MEETUPS , method: .get , params: nil , headers: nil) { (json, error) in
            if json != nil {
                let response = BaseResponse.init(dict: json!)
                if response.Status{
                    if let data = response.Obj["Result"] as? [[String : Any]]{
                        let list = Event.getList(data: data)
                        completion(.sucess , list )
                    }else{
                         completion(.sucess , response.Message)
                    }
                }else{
                    //get error
                    completion(.error , response.Message == "" ?  "Something went wrong!".localize() : response.Status)
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
    
    func getPastMeetUps(completion:@escaping(ResponseStatus,Any)->Void) {
          
          BaseAPI(url: Constants.GET_Past_MEETUPS , method: .get , params: nil , headers: nil) { (json, error) in
              if json != nil {
                  let response = BaseResponse.init(dict: json!)
                  if response.Status{
                      if let data = response.Obj["Result"] as? [[String : Any]]{
                          let list = Event.getList(data: data)
                          completion(.sucess , list )
                      }else{
                          completion(.sucess , response.Message)
                      }
                  }else{
                      //get error
                      completion(.error , response.Message == "" ?  "Something went wrong!".localize() : response.Status)
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
    
    
    func getFavouriteMeetUps(completion:@escaping(ResponseStatus,Any)->Void) {
            
        let userId = 6
        let url = Constants.GET_FAVOURITE_MEETUPS + "\(userId)"
        
            BaseAPI(url: url, method: .get , params: nil , headers: nil) { (json, error) in
                if json != nil {
                    let response = BaseResponse.init(dict: json!)
                    if response.Status{
                        if let data = response.Obj["Result"] as? [[String : Any]]{
                            let list = Event.getList(data: data)
                            completion(.sucess , list )
                        }else{
                            completion(.sucess , response.Message)
                        }
                    }else{
                        //get error
                        completion(.error , response.Message == "" ?  "Something went wrong!".localize() : response.Status)
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
    
    
    func getJointMeetUps(completion:@escaping(ResponseStatus,Any)->Void) {
            
           let userId = 6
           let url = Constants.GET_JOINT_MEETUPS + "\(userId)"
           
        
            BaseAPI(url: url , method: .get, params: nil , headers: nil) { (json, error) in
                if json != nil {
                    let response = BaseResponse.init(dict: json!)
                    if response.Status{
                        if let data = response.Obj["Result"] as? [[String : Any]]{
                            let list = Event.getList(data: data)
                            completion(.sucess , list )
                        }else{
                        completion(.sucess , response.Message)
                   }
                    }else{
                        //get error
                        completion(.error , response.Message == "" ?  "Something went wrong!".localize() : response.Status)
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
    
    
}
