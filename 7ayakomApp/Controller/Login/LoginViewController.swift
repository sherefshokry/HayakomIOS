//
//  LoginViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/19/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit
import KVNProgress

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var mailFeild : LoginInputFeild!
    @IBOutlet weak var passWordFeild : LoginInputFeild!
    
    
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
//       Utils.openHomeScreen()
        if !validate(){
            return
        }
        
        performApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollToTop()
    }

    func validate()->Bool{
        var isValid = true
        isValid = mailFeild.validate() && isValid
        isValid = passWordFeild.validate() && isValid
        return isValid
    }
    
    func performApi(){
        let dataSource = UserDataSource()
        KVNProgress.show()
        dataSource.login(userName: mailFeild.getText().trim() , userPassword: passWordFeild.getText(), completion:  { (status, response) in
            KVNProgress.dismiss()
            switch status{
            case .sucess :
                Utils.openHomeScreen()
                break
            case .error :
                self.showMessage(response as? String ?? "حدث خطأ ما")
                break
            case .networkError :
                self.showMessage(response as? String ?? "حدث خطأ ما")
                break
            }
        })
    }
 
}
