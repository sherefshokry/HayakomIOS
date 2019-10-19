//
//  LoginViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/19/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    
    var openRegistrationHandler : (()->())!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openRegistrationScreen(_ sender : Any){
        scrollView.scrollToTop()
        if openRegistrationHandler != nil{
            openRegistrationHandler()
        }
        
    }
    
    @IBAction func login(_ sender : Any){
       Utils.openHomeScreen()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollToTop()
    }

 
}
