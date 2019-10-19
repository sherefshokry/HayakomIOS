//
//  LastMessagestVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/14/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import SDWebImage

class LastMessagestVC : UIViewController {
    
  
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    var lastMessages = [LastMessage]()
    let userId = 50
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenToLastMessage()
    }
    
    
    func listenToLastMessage(){
        let db = Firestore.firestore()
        db.collection("Chat").document("convs_\(userId)").collection("threads_\(userId)")
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                self.fetchLastMessages()
                
        }
    }
    
    
    func fetchLastMessages(){
        
        showIndicator()
        let db = Firestore.firestore()
       db.collection("Chat").document("convs_\(userId)").collection("threads_\(userId)").getDocuments { (snapShot, error) in
            self.hideIndicator()
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                
                self.lastMessages = []
                
                for document in snapShot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let message = LastMessage.init(dict: document.data())
                    self.lastMessages.append(message)
                    
                }
            }
            if self.lastMessages.count == 0 {
                self.tableView.isHidden = true
            }else{
                self.tableView.isHidden = false
            }
            self.tableView.reloadData()
        }
    }
    
    func showIndicator(){
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func hideIndicator(){
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    
    
    @IBAction func openSearchVC(_ sender : UIButton){
        let vc = SearchVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        self.present(vc, animated: true, completion: nil)
   }
    
}
extension LastMessagestVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LastMessageCell", for: indexPath) as! LastMessageCell
        cell.setData(message: lastMessages[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChatVC.instantiateFromStoryBoard(appStoryBoard: .Home)
        vc.reciverUser = lastMessages[indexPath.row].user
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}


