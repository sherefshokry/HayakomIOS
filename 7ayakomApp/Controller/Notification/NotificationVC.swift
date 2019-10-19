//
//  NotificationVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/17/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit

class NotificationVC : UIViewController {
    
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    
    var notificationList = [UserNotificaton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
   }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         fetchNotificationData()
    }
    
    
   func  fetchNotificationData(){
     showIndicator()
     notificationList = []
    let dataSource = NotificationDataSource()
    dataSource.getAllNotification { (response, result) in
        self.hideIndicator()
        switch response {
        case .sucess :
            self.notificationList = result as? [UserNotificaton] ?? []
            self.tableView.reloadData()
            
            if self.notificationList.count == 0 {
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false
            }
               break
        case .error :
            self.showMessage(result as? String ?? "")
           break
            case .networkError :
            self.showMessage(result as? String ?? "")
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
    
    
}
extension NotificationVC : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  self.notificationList.count
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.setData(notification: notificationList[indexPath.row])
        return cell
    }
    
  
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Notification selected")
    }
    
    
}
