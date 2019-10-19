//
//  RegistrationViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/19/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var scrollView : UIScrollView!
    
    
    var openLoginHandler : (()->())!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.scrollToTop()
    }
    
    @IBAction func openLoginScreen(_ sender : Any){
        scrollView.scrollToTop()
        if openLoginHandler != nil {
            openLoginHandler()
        }
        
    }
    
    @IBAction func register(_ sender : Any){
        let vc = SelectCategoriesViewController.instantiateFromStoryBoard(appStoryBoard: .Prefrences)
        Utils.getNavigationController()?.pushViewController(vc, animated: true)
        
    }


}
