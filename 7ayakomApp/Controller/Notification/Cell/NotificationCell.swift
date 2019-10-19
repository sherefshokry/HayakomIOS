//
//  NotificationCell.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/17/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import  UIKit
import  SDWebImage

class NotificationCell : UITableViewCell {
    
    @IBOutlet weak var meetUpName : UILabel!
    @IBOutlet weak var notificationImage : UIImageView!
    @IBOutlet weak var notificationTitle : UILabel!
    @IBOutlet weak var notificationDate : UILabel!
    
    
    func setData(notification : UserNotificaton){
       notificationTitle.text =  notification.notificationText
        notificationDate.text = getDate(dateString : notification.notificationDate)
        meetUpName.text = notification.meetUpName 
    }
    
    func getDate(dateString : String)->String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
           let date = dateFormatter.date(from: dateString)
           dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
           dateFormatter.dateFormat = "EEEE dd MMMM yyyy"
           
           return  dateFormatter.string(from: date!)
       }
    
    
}
