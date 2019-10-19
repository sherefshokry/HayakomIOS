//
//  EventTableViewCell.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/21/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle : UILabel!
    @IBOutlet weak var eventImage : UIImageView!
    @IBOutlet weak var eventLocation : UILabel!
    @IBOutlet weak var eventDate : UILabel!
    var event = Event()


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(event : Event){
        self.event = event
        eventImage.setShowActivityIndicator(true)
        eventImage.setIndicatorStyle(.gray)
        eventImage.sd_setImage(with: URL.init(string: event.MeetupImagePath), placeholderImage: nil)
        eventTitle.text = event.MeetupName
        eventLocation.text = event.MeetupFullLocation
        eventDate.text = getDate(dateString: event.MeetupDate)
    }
    
    func getDate(dateString : String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
    }
    
    
    
    @IBAction func openEventDetails(_ sender : UIButton){
        let vc = EventDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        vc.eventId = event.MeetupId
        UIApplication.shared.windows[0].visibleViewController?.present(vc, animated: true, completion: nil)
    }
    
    
    
}
