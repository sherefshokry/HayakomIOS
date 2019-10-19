//
//  EventDetailsViewController.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/11/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//
import UIKit
import KVNProgress

class EventDetailsViewController : UIViewController {
    
    @IBOutlet weak var eventImage : UIImageView!
    @IBOutlet weak var eventTitle : UILabel!
    @IBOutlet weak var eventDate : UILabel!
    @IBOutlet weak var eventTime : UILabel!
    @IBOutlet weak var eventLocation : UILabel!
    @IBOutlet weak var eventDetails : UILabel!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var joinBtn : UIButton!
    @IBOutlet weak var firstUserImage : UIImageView!
    @IBOutlet weak var secondUserImage : UIImageView!
    @IBOutlet weak var thirdUserImage : UIImageView!
    @IBOutlet weak var attendersNumber : UILabel!
    
    var eventId = 0
    
    
    
    @IBAction func navigateToAddress(_ sender : Any){
         print("navigate")
}
    
    @IBAction func joinMeetup(_ sender : Any){
        print("join")
       }
    
    @IBAction func addMeetupToFavourite(_ sender : Any){
        print("Favourite")
       }
    
    
    @IBAction func addComment(_ sender : Any){
       print("Comment")
    }
    
    
    var event : Event = Event()
    var commentList : [Comment] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailsData()
    }
    
    func loadDetailsData(){
      
        let dataSource = EventDetailsDataSource()
        KVNProgress.show()
        dataSource.getMeetUpDetails { (status, response) in
            KVNProgress.dismiss()
               switch status{
               case .sucess :
                   self.event = response as? Event ?? Event()
                   self.setEventData()
                   self.loadComments()
                   break
               case .error :
                   self.showMessage((response as? String)!)
                   break
               case .networkError :
                   self.showMessage((response as? String)!)
                   break
               }
           }
  }
    
    
    func loadComments(){
        let dataSource = CommentDataSource()
          KVNProgress.show()
          dataSource.getComments { (status, response) in
              KVNProgress.dismiss()
                 switch status{
                 case .sucess :
                     self.commentList = response as? [Comment] ?? []
                     
                     break
                 case .error :
                     self.showMessage((response as? String)!)
                     break
                 case .networkError :
                     self.showMessage((response as? String)!)
                     break
                 }
             }
        
    }
    
    
    func setEventData(){
        eventTitle.text = event.MeetupName
        eventImage.sd_setImage(with: URL.init(string: event.MeetupImagePath))
   }
    
    
}
