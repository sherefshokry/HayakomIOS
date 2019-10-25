//
//  LastMessageCell.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/14/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit
import SDWebImage

class LastMessageCell : UITableViewCell {
  
      @IBOutlet weak var messageTime : UILabel!
      @IBOutlet weak var userImage : UIImageView!
      @IBOutlet weak var userName : UILabel!
      @IBOutlet weak var userLastMsg : UILabel!
      @IBOutlet weak var stackView : UIStackView!
    

    func setData(message : LastMessage){
        let messageDate =  message.lastMessageDate.toDate()
        messageTime.text = messageDate.getElapsedInterval()
        userLastMsg.text = message.lastMessage
        userName.text = message.user.UserName
    
        userImage.sd_setImage(with:  URL(string: message.user.ImagePath),placeholderImage: UIImage(named: "splash")) { (image, error, cache, url) in
           
        }
  }
    
 
  
    
    
    
}
