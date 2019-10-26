//
//  CommentVC.swift
//  7ayakomApp
//
//  Created by SherifShokry on 10/25/19.
//  Copyright © 2019 Nora Sayed. All rights reserved.
//

import UIKit

class CommentVC : UIViewController {
    
    @IBOutlet weak var textView : UITextView!
    var commentCompletion : ((String)->())?

    
    override func viewDidLoad() {
        super.viewDidLoad()
           hideKeyboardWhenTappedAround()
        
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
    
    
    @IBAction func sendCommentPressed(_ sender : UIButton){
       if !textView.text.trimmingCharacters(in: .whitespaces).isEmpty {
        self.dismiss(animated: true) {
            self.commentCompletion!(self.textView.text)
        }
       
        }
    }
      
      
    
    
}
