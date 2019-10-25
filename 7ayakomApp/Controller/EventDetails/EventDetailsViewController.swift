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
    var numberOfRows = 10
    var lastIndex = 9
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
        let vc = CommentVC.instantiateFromStoryBoard(appStoryBoard: .Events)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func shareMeetUp(_ sender : Any){
      print("share")
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
                    // self.tableView.reloadData()
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
extension EventDetailsViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastMessageCell", for: indexPath) as! LastMessageCell
        tableCellsHeight += cell.stackView.frame.height
        self.tableHeightConstraint.constant = tableCellsHeight + CGFloat(320)
        self.view.layoutIfNeeded()
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
    
    
    
    
}
