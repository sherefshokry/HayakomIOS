//
//  EventDetailsDataSource.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/11/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//
import Foundation

class EventDetailsDataSource: BaseAPI {
    func getMeetUpDetails(completion:@escaping(ResponseStatus,Any)->Void) {
        let eventId = 2
        let userId = 6
        let url = Constants.GET_MEETUP_DETAILS +  "?MeetupId=\(eventId)&UserId=\(userId)"
        
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
