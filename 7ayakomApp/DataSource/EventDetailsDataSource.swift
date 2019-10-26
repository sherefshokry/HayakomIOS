//
//  EventDetailsDataSource.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/11/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//
import Foundation

class EventDetailsDataSource: BaseAPI {
    
     func addComment(comment : String , meetupId : Int ,completion:@escaping(ResponseStatus,Any)->Void ) {
         
        let userId = 6
         let url = Constants.ADD_COMMENT +  "?ParetCommentId=0&MeetupId=\(meetupId)&UserId=\(userId)&Comment=\(comment)"
        
         let validUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
          BaseAPI(url: validUrl , method: .post , params: nil , headers: nil) { (json, error) in
                    if json != nil {
                        let response = BaseResponse.init(dict: json!)
                        if response.Status{
                            completion(.sucess , response.Message)
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
     
     
     
    
    
    func joinMeetup(meetupId : Int,completion:@escaping(ResponseStatus,Any)->Void){
          
          let userId = 6
          let url = Constants.JOIN_MEETUP +  "?MeetupId=\(meetupId)&UserId=\(userId)"
          
          BaseAPI(url: url , method: .post , params: nil , headers: nil) { (json, error) in
              if json != nil {
                  let response = BaseResponse.init(dict: json!)
                  if response.Status{
                      completion(.sucess , response.Message)
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
    
    
    func addMeetupToFavourite(meetupId : Int,completion:@escaping(ResponseStatus,Any)->Void){
        
        let userId = 6
        let url = Constants.ADD_MEETUP_TO_FAVOURITE +  "?MeetupId=\(meetupId)&UserId=\(userId)"
        
        BaseAPI(url: url , method: .post , params: nil , headers: nil) { (json, error) in
            if json != nil {
                let response = BaseResponse.init(dict: json!)
                if response.Status{
                    completion(.sucess , response.Message)
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
    
    
    
    
    func getMeetUpDetails(meetupId : Int,completion:@escaping(ResponseStatus,Any)->Void) {
        let userId = 6
        let url = Constants.GET_MEETUP_DETAILS +  "?MeetupId=\(meetupId)&UserId=\(userId)"
        
        BaseAPI(url: url , method: .get , params: nil , headers: nil) { (json, error) in
            if json != nil {
                
                let response = BaseResponse.init(dict: json!)
                if response.Status{
                    if let data = response.Obj["Result"] as? [String : Any]{
                        let event =  Event.init(dict: data)
                        completion(.sucess , event )
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
