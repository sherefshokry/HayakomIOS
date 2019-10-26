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
    @IBOutlet weak var eventGuest : UILabel!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var joinBtn : UIButton!
    @IBOutlet weak var firstUserImage : UIImageView!
    @IBOutlet weak var secondUserImage : UIImageView!
    @IBOutlet weak var thirdUserImage : UIImageView!
    @IBOutlet weak var userStackView : UIStackView!
    @IBOutlet weak var attendersNumber : UILabel!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var locationImage : UIImageView!
    @IBOutlet weak var favouriteBtn : UIButton!
    @IBOutlet weak var shareBtn : UIButton!
    @IBOutlet weak var tableHeightConstraint : NSLayoutConstraint!
    var tableCellsHeight =  CGFloat(0)
    var eventId = 0
    var commentsList = [Comment]()
    
    
    @IBAction func navigateToAddress(_ sender : Any){
        Utils.navigateToMap(latitude: event.MeetupLatitude, longitude: event.MeetupLongitude)
}
    
    @IBAction func joinMeetup(_ sender : Any){
        
    }
    
    @IBAction func addMeetupToFavourite(_ sender : Any){
          addMeetupToFavourite()
    }
    
    @IBAction func addComment(_ sender : Any){
        let vc = CommentVC.instantiateFromStoryBoard(appStoryBoard: .Events)
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func shareMeetUp(_ sender : Any){
      print("share")
    }
    var event : Event = Event()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailsData()
    }
    
    func loadDetailsData(){
      
        let dataSource = EventDetailsDataSource()
        KVNProgress.show()
        dataSource.getMeetUpDetails(meetupId: eventId) { (status, response) in
            KVNProgress.dismiss()
               switch status{
               case .sucess :
                   self.event = response as? Event ?? Event()
                   self.setEventData()
                   self.loadComments()
                   break
               case .error :
                   self.showMessage(response as? String ?? "")
                   break
               case .networkError :
                   self.showMessage(response as? String ?? "")
                   break
               }
           }
  }
    
    
    func loadComments(){
        let dataSource = CommentDataSource()
          KVNProgress.show()
        dataSource.getComments(meetupId: eventId) { (status, response) in
              KVNProgress.dismiss()
                 switch status{
                 case .sucess :
                     self.commentsList = response as? [Comment] ?? []
                     self.reloadTableData()
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
    
    
     func addMeetupToFavourite(){
         let dataSource = EventDetailsDataSource()
         KVNProgress.show()
        dataSource.addMeetupToFavourite(meetupId : eventId) { (status, response) in
               KVNProgress.dismiss()
                  switch status{
                  case .sucess :
                    self.showMessage(response as? String ?? "") {
                        self.favouriteBtn.isSelected = !self.favouriteBtn.isSelected
                    }
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


    func reloadTableData(){
        tableCellsHeight =  CGFloat(0)
        self.tableView.reloadData()
    }
    
    func setEventData(){
        eventTitle.text = event.MeetupName
        eventDetails.text = event.MeetupDetails
        eventLocation.text = event.MeetupFullLocation
       // eventGuest.text = event.
        if event.isFavourite == 1 {
           favouriteBtn.isSelected = true
        }else{
          favouriteBtn.isSelected = true
        }
        eventImage.sd_setImage(with: URL.init(string: event.MeetupImagePath),placeholderImage: UIImage(named: "splash"))
        attendersNumber.text = "\(event.attenders) +"
        firstUserImage.isHidden = !(event.meetupAttenderUsers.count >= 1)
        secondUserImage.isHidden = !(event.meetupAttenderUsers.count  >= 2)
              thirdUserImage.isHidden = !(event.meetupAttenderUsers.count  >= 3)
        event.meetupAttenderUsers.count >= 1 ? firstUserImage.sd_setImage(with: URL.init(string:  event.meetupAttenderUsers[0].imagePath),placeholderImage: UIImage(named: "splash")) : firstUserImage.sd_setImage(with: URL.init(string: ""))
                      
        event.meetupAttenderUsers.count >= 2 ? secondUserImage.sd_setImage(with: URL.init(string:  event.meetupAttenderUsers[1].imagePath)) : secondUserImage.sd_setImage(with: URL.init(string: ""),placeholderImage: UIImage(named: "splash"))
                      
        event.meetupAttenderUsers.count >= 3 ? thirdUserImage.sd_setImage(with: URL.init(string:  event.meetupAttenderUsers[2].imagePath),placeholderImage: UIImage(named: "splash")) : thirdUserImage.sd_setImage(with: URL.init(string: ""))
        
         }
    
}
extension EventDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastMessageCell", for: indexPath) as! LastMessageCell
        cell.setData(comment: commentsList[indexPath.row])
        tableCellsHeight += cell.stackView.frame.height// + CGFloat(32)
         self.tableHeightConstraint.constant = (tableCellsHeight)///2
         self.view.layoutIfNeeded()
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
