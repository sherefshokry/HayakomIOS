//
//  MessageReciverCell.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/17/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit

class MessageReciverCell : UITableViewCell {

    
    @IBOutlet weak var backView : UIView!
    @IBOutlet weak var messageLabel : UILabel!
    @IBOutlet weak var messageDateLabel : UILabel!
    
        override class func awakeFromNib() {
            super.awakeFromNib()
       }
    override func layoutSubviews() {
        super.layoutSubviews()
     //   self.backView.roundCorners(topLeft: 15.0, topRight: 15.0, bottomLeft: 15.0, bottomRight: 0)
    }

    func setData(message : Message){
        messageLabel.text = message.message
        messageDateLabel.text = getTime(dateString: message.messageDate)
  }
    
    
    func getTime(dateString : String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss yyyy/MM/dd"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
        dateFormatter.dateFormat = "hh:mm a"
        
        return  dateFormatter.string(from: date ?? Date())
    }
    
}
