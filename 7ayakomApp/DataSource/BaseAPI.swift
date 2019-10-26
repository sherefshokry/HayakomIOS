//
//  BaseAPI.swift
//  Loreal
//
//  Created by Nora on 2/14/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import Alamofire
import Arrow

class BaseAPI : Any {
    //swagger link http://hayakomapi.natlab.net/swagger/ui/index#/
    struct  Constants {
        static var BASE_URL = "http://hayakomapi.natlab.net/api"
        static var GET_CATEGORIES = BASE_URL + "/MobileCategory/GetAllCategories"
        static var GET_ALL_MEETUPS = BASE_URL + "/MobileMeetup/GetAllMeetup"
          static var GET_Past_MEETUPS = BASE_URL + "/MobileMeetup/GetPastMeetups"
        static var GET_JOINT_MEETUPS = BASE_URL + "/MobileMeetup/GetUserJoinedMeetups?UserId="
        static var GET_FAVOURITE_MEETUPS = BASE_URL +
        "/MobileMeetup/GetUserFavouriteMeetups?UserId="
        static var GET_MEETUP_DETAILS = BASE_URL + "/MobileMeetup/GetMeetupDetailsWithFav"
        static var GET_COMMENTS = BASE_URL + "/MobileMeetupComments/GetMeetupComments?MeetupId="
        static var GET_NOTIFICATIONS = BASE_URL +
               "/MobileMobileUser/GetNotificationDetailsByUserId?UserId="
        static var GET_USERS_BY_NAME = BASE_URL + "/MobileMobileUser/GetMobileUsersByName?Name="
        
        static var ADD_MEETUP_TO_FAVOURITE = BASE_URL + "/MobileMeetup/AddMeetToUserFavourites"
        
        
        
      static var LOGIN = BASE_URL + "Login"
//
        
        
    }
    var errorKey = "Message"
    var unauthorizedHeader =  [
        "Content-Type" : "application/json" ,
        "Accept" : "application/json"]
    
    public enum ResponseStatus: String {
        case error = "error"
        case sucess = "success"
        case networkError = "networkError"
    }
    
    func BaseAPI(url:String ,method: Alamofire.HTTPMethod,params:[String:Any]? , headers :[String:Any]? ,completion:@escaping([String:Any]?,Error?)->Void){
        
        Alamofire.request(url, method:method, parameters:params, encoding:JSONEncoding.default, headers:headers as? [String : String])
            .responseJSON { (response) in
                print(response.result.value ?? "")
                switch(response.result){
                case .success(_):
                     print(response.result.value ?? "")
                    let json = response.result.value as? [String: Any]
                    completion(json,nil)
                    break
                case .failure(_):
                    completion(nil,response.error)
                    break
                }
        }
        
    }
    
    
    
    
    func Upload(url:String ,filePathUrl:URL? ,video:Bool , completion:@escaping([String:Any]?,Error?)->Void){
       
        
        let serverURL = URL.init(string: url)!

        let headers = ["Content-Type" : "multipart/form-data"]
        let url = try! URLRequest(url: serverURL, method: .post, headers: headers)
        
        do {
            let data = try Data.init(contentsOf: filePathUrl!)
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    //multipartFormData.append(filePathUrl!, withName: "file")
//                    multipartFormData.append(data, withName: "file" ,fileName: "test.m4a" , mimeType: video! ? "video/*" : "audio/*")
                    if video{
                         multipartFormData.append(data, withName: "file" ,fileName: "test.mp4" , mimeType:  "video/*" )
                    }else{
                         multipartFormData.append(data, withName: "file" ,fileName: "test.m4a" , mimeType:  "audio/*")
                    }
            },
                with: url,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            
                            print(response.result.value ?? "")
                            let json = response.result.value as? [String: Any]
                            completion(json,nil)
                        }
                        
                        break
                    case .failure(let en_Error):
                        print(en_Error.localizedDescription)
                        completion(nil,nil)
                        break
                    }
            }
            )
        } catch {
            print ("loading file error")
        }

    }

    
    
//    func getHeader ()->[String : Any]{
////        print(UserDataSource.getUserToken())
//        return ["Authorization":"Bearer \(UserDataSource.getUserToken())" ,
//            "Content-Type" : "application/json" ,
//            "Accept" : "application/json"]
//    }
//
    func getTokenOnlyHeader ()->[String : Any]{
        print(UserDataSource.getUserToken())
        return ["Authorization":"Bearer \(UserDataSource.getUserToken())"
            ]
    }
    
}
