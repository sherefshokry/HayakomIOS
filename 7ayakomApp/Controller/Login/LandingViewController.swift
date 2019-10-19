//
//  LandingViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    private lazy var loginViewController : LoginViewController = {
        var viewControler = LoginViewController.instantiateFromStoryBoard(appStoryBoard: .Login)
        viewControler.openRegistrationHandler = {
            self.openRegistration()
        }
        self.add(childViewContoller: viewControler)
        return viewControler
    }()
    
    private lazy var regissterViewController : RegistrationViewController = {
        var viewControler = RegistrationViewController.instantiateFromStoryBoard(appStoryBoard: .Login)
        viewControler.openLoginHandler = {
            self.openLogin()
        }
        self.add(childViewContoller: viewControler)
        return viewControler
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        add(childViewContoller: loginViewController)
        // Do any additional setup after loading the view.
    }
    

    private func add(childViewContoller : UIViewController){
        addChild(childViewContoller)
        self.view.addSubview(childViewContoller.view)
        childViewContoller.view.frame = self.view.bounds
        childViewContoller.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewContoller.didMove(toParent: self)
    }
    
    private func remove(childViewContoller : UIViewController){
        childViewContoller.willMove(toParent: nil)
        childViewContoller.view.removeFromSuperview()
        childViewContoller.removeFromParent()
    }
    
    
    func openRegistration(){
        remove(childViewContoller: loginViewController)
        add(childViewContoller: regissterViewController)
    }
    
    func openLogin(){
        remove(childViewContoller: regissterViewController)
        add(childViewContoller: loginViewController)
    }

}
