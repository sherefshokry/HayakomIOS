//
//  EventsVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/18/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit

class EventsVC : UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
     var list = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func loadData(){
           let dataSource = EventDataSource()
           showIndicator()
           dataSource.getAllMeetUps { (status, response) in
               self.hideIndicator()
               switch status{
               case .sucess :
                   self.list = response as? [Event] ?? [Event]()
                   if self.list.count == 0 {
                       
                       self.tableView.isHidden = true
                   }else{
                       self.tableView.isHidden = false
                   }
                self.tableView.reloadData()
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
    
    func showIndicator(){
          indicator.isHidden = false
          indicator.startAnimating()
      }
      
      
      func hideIndicator(){
         indicator.isHidden = true
         indicator.stopAnimating()
     }
    
    
    @IBAction func addEvent(_ sender : UIButton){
        
        print("add event")
        
    }
    
}
extension EventsVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
   }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell") as? EventTableViewCell
        cell?.setData(event: list[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = EventDetailsViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        vc.eventId = list[indexPath.row].MeetupId
        self.present(vc, animated: true, completion: nil)
    }

    
    
}

