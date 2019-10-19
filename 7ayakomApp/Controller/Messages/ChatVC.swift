//
//  ChatVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/16/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//
import UIKit
import FirebaseCore
import FirebaseFirestore
import SDWebImage

class ChatVC : UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    @IBOutlet weak var textView : UITextView!
    @IBOutlet weak var messageBottomBarView : UIView!
    @IBOutlet weak var userNameLbl : UILabel!
    @IBOutlet weak var userImg : UIImageView!
    var senderUserId = 100
    var reciverUserId = 99
    var collectionId = ""
    var messagesList = [Message]()
    var reciverUser = User()
    var status = false
    override func viewDidLoad() {
        super.viewDidLoad()
     
        hideKeyboardWhenTappedAround()
        setReciverUserData()
        calcCollectionId()
        listenToNewMessage()
        fetchChatMessages()
        textView.delegate = self
       
    }
    
    
    func listenToNewMessage(){
        let db = Firestore.firestore()
        db.collection("Chat").document("messages").collection(collectionId)
            .addSnapshotListener(includeMetadataChanges: true) { documentSnapshot, error in
                if self.status {
                   self.fetchChatMessages()
                }
               
        }
    }
    
    func setReciverUserData() {
        userNameLbl.text = reciverUser.UserName
        userImg.sd_setImage(with:  URL(string: reciverUser.ImagePath),placeholderImage: UIImage(named: "splash")) { (image, error, cache, url) in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(keyboardWillShow),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(keyboardWillHide),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
   }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                   if self.view.frame.origin.y != 0{
                       self.view.frame.origin.y += keyboardSize.height
                   }
               }
        
        
    }
    
    
    func calcCollectionId(){
        
        if senderUserId < reciverUserId  {
            collectionId = "\(senderUserId)_\(reciverUserId)"
        }else{
            collectionId = "\(reciverUserId)_\(senderUserId)"
        }
        
    }
    
    func fetchChatMessages(){
        messagesList = []
     
        showIndicator()
        let db = Firestore.firestore()
        db.collection("Chat").document("messages").collection(collectionId).order(by: "messageTime", descending: false).getDocuments { (snapShot, error) in
            self.hideIndicator()
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in snapShot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let message = Message.init(dict: document.data())
                    self.messagesList.append(message)
                }
            }
            self.tableView.reloadData()
            self.scrollToBottom()
            self.status = true
        }
          

    }
    

    
    func fetchMoreMessages(){
        
        
    }
    
    func showIndicator(){
        indicator.isHidden = false
        indicator.startAnimating()
    }
    
    func hideIndicator(){
        indicator.isHidden = true
        indicator.stopAnimating()
    }
    
    
    func convertObjectToJSON(user : User) -> String{
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(user)
        let userJson = String(data: data, encoding: .utf8)!
        
        return userJson
        
    }
    
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.messagesList.count > 1 {
                let indexPath = IndexPath(row: self.messagesList.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        }
    }
    
    
    @IBAction func sendMessage(_ sender : UIButton){
        
        
        if textView.text.count > 0 {
            let mockUser = User(UserId: 100, UserName: "shokoko", gender: "male", ImagePath: "fdf", Email: "shokry@yahoo.com")
            let mockReciverUser = User(UserId: 99, UserName: "shetooz", gender: "female", ImagePath: "fdf", Email: "shokry@yahoo.com")
            
            let db = Firestore.firestore()
            let userJson = convertObjectToJSON(user: mockUser)
            let userReciverJson = convertObjectToJSON(user: mockReciverUser)
            
            let newMessage = [ "messageText" : textView.text!,
                               "senderUser" : userJson,
                               "messageTime" : Date().getDateString()
                ] as [String : Any]
            
            let lastMessage = [ "lastMsg" :  textView.text!,
                                "receiverUser" : userReciverJson,
                                "lastMsgDate" : Date().getDateString()
                ] as [String : Any]
            let lastReciverMessage = [ "lastMsg" :  textView.text!,
                                       "receiverUser" : userJson,
                                       "lastMsgDate" : Date().getDateString()
                ] as [String : Any]
            
            
            //add new message to list
            db.collection("Chat").document("messages").collection(collectionId).addDocument(data: newMessage) { (error) in
            //    self.showMessage(error?.localizedDescription ?? "")
            }
            
            //update last message
            db.collection("Chat").document("convs_\(senderUserId)").collection("threads_\(senderUserId)").document("to_\(reciverUserId)").setData(lastMessage) { (error) in
             //   self.showMessage(error?.localizedDescription ?? "")
            }
            
            //update reciver lastMessage
            db.collection("Chat").document("convs_\(reciverUserId)").collection("threads_\(reciverUserId)").document("to_\(senderUserId)").setData(lastReciverMessage) { (error) in
              //  self.showMessage(error?.localizedDescription ?? "")
            }
            
            
            self.view.endEditing(true)
            self.textView.text = ""
      }
        
    
    }
    
    
}
extension ChatVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  messagesList[indexPath.row].user.UserId == 100 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageSenderCell", for: indexPath) as! MessageSenderCell
            cell.setData(message: messagesList[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageReciverCell", for: indexPath) as! MessageReciverCell
            cell.setData(message: messagesList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
extension ChatVC : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
     //   self.view.endEditing(true)
       // textView.resignFirstResponder()
    }

    
}
