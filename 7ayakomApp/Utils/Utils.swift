//
//  Utils.swift
//  Loreal Medical
//
//  Created by Nora on 3/18/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    case Login = "Login"
    case Prefrences = "Prefrences"
    case Home = "Home"
    case Events = "Events"
    
   
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type)->T{
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID ) as! T
    }
}

class Utils {
    static func openLogin(){
        let vc = LandingViewController.instantiateFromStoryBoard(appStoryBoard: .Login)
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.isHidden = true
        UIApplication.shared.windows[0].rootViewController = nvc
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }
    
    
    static func openHomeScreen(){
        let vc = HomeTabViewController.instantiateFromStoryBoard(appStoryBoard: .Home)
        vc.selectedIndex = 3
        let nvc = UINavigationController(rootViewController: vc)
        nvc.navigationBar.isHidden = true
        UIApplication.shared.windows[0].rootViewController = nvc
        UIApplication.shared.windows[0].makeKeyAndVisible()
    }

    static func getNavigationController()->UINavigationController?{
        let root = (UIApplication.shared.windows[0].rootViewController)
        if root is UINavigationController{
            return root as? UINavigationController
        }else{
            return nil
        }
    }
    static func getNotificationStatus()->Bool{
        if let status = UserDefaults.standard.value(forKey: Constants.NOTIFICATIONS) as? Bool{
            return status
        }
        return true
    }
 
    
}
