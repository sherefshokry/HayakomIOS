//
//  SearchCell.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/19/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit
import SDWebImage

class SearchCell : UITableViewCell {
    
    
    @IBOutlet weak var userName : UILabel!
    @IBOutlet weak var userImage : UIImageView!
    
    
    
    func setData(user : User){
        
        userName.text = user.UserName
        userImage.sd_setImage(with:  URL(string: user.ImagePath),placeholderImage: UIImage(named: "splash")) { (image, error, cache, url) in
                
             }
        
    }
    
    
}
