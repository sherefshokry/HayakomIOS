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
    
    
    static func navigateToMap(latitude : String , longitude : String){
        
    if UIApplication.shared.canOpenURL(URL.init(string:"comgooglemaps://")!) {
             let url = URL.init(string: "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
       // }
            

    }
    }
    
    static func shareMeetup(vc : UIViewController,link : String) {

        let textToShare = [link] //[URL.init(string: link)]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any],
                applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.airDrop]

        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2,
                    y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
            popoverController.sourceView = vc.view
            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        }
        vc.present(activityViewController, animated: true, completion: nil)

    }
    
    
    static func getNotificationStatus()->Bool{
        if let status = UserDefaults.standard.value(forKey: Constants.NOTIFICATIONS) as? Bool{
            return status
        }
        return true
    }
 
    
}
