//
//  PrefrencesDataSource.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation

class PrefrencesDataSource : BaseAPI{
    
    func getCategories(completion:@escaping(ResponseStatus,Any)->Void) {
        
        BaseAPI(url: Constants.GET_CATEGORIES + "?IsActive=true" , method: .get , params: nil , headers: nil) { (json, error) in
            if json != nil {
                let response = BaseResponse.init(dict: json!)
                if response.Status{
                    if let data = response.Obj["Result"] as? [[String : Any]]{
                        let list = Category.getList(data: data)
                        completion(.sucess , list )
                    }else{
                        completion(.error , response.Message == "" ?  "Something went wrong!".localize() : response.Status)
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
