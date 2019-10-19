//
//  SearchDataSource.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/19/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import Foundation

class SearchDataSource : BaseAPI{
    
 
    func searchUsersByName(userName : String,page : Int ,  completion:@escaping(ResponseStatus,Any)->Void) {
        let userId = 6
        let url = Constants.GET_USERS_BY_NAME + userName + "&userId=\(userId)&pageSize=\(Pagination.per_page)&currentPage=\(page)"
        
        let validUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        
        
        BaseAPI(url: validUrl  , method: .get , params: nil , headers: nil) { (json, error) in
            if json != nil {
                let response = BaseResponse.init(dict: json!)
                let status = json!["Status"] as? Bool ?? false
//                let sucess = (errorCode == 0)
                if status{
//                    completion(.sucess , "" )
                    if let data = response.Obj["Result"] as? [[String : Any]]{
                        // get user
                        let userList = User.getList(data: data)
                        completion(.sucess , userList )
                    }else{
                        completion(.sucess , [])
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
    
  

}
