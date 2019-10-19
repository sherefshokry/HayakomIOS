//
//  GoingViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/21/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GoingViewController: UIViewController {

    
    @IBOutlet weak var tableView : UITableView!
     @IBOutlet weak var indicator : UIActivityIndicatorView!
        @IBOutlet weak var stackView : UIStackView!
    
     var list = [Event]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          loadData()
      }
    
    func loadData(){
           let dataSource = EventDataSource()
           showIndicator()
           dataSource.getJointMeetUps { (status, response) in
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
                   self.showMessage(response as? String ?? "")
                   break
               case .networkError :
                   self.showMessage(response as? String ?? "")
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
extension GoingViewController : IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "ذاهب".localize())
    }
    
}
extension GoingViewController : UITableViewDataSource , UITableViewDelegate{
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
