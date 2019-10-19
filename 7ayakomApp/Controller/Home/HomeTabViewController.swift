//
//  HomeTabViewController.swift
//  A3maly
//
//  Created by Nora Sayed on 9/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class HomeTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        // Do any additional setup after loading the view.
    }

    func setUpTabBar(){
        let tabBar = self.tabBar
        tabBar.isTranslucent = false
    //    tabBar.backgroundColor = Colors.appPrimeryColor
     //   tabBar.selectedImageTintColor = Colors.appPrimeryColor
//        tabBar.selectionIndicatorImage = createSelectionIndicator(color:  Colors.appPrimeryColor, size: CGSize.init(width:tabBar.frame.width/CGFloat(tabBar.items!.count) , height:tabBar.frame.height), lineHeight: 2.0)
        
        for vc in self.viewControllers! {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
        }
       
//            UIImage().createSelectionIndicator(color: UIColor.init(codeString: "22B7E5"), size: CGSize.init(width:tabBar.frame.width/CGFloat(tabBar.items!.count) / 2.0 , height:tabBar.frame.height), lineWidth: 2.0)
      
    }

    //func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        
        //UIGraphicsBeginImageContextWithOptions(size, false, 0)
        //color.setFill()
//        let w : CGFloat = 14.0
////        let y = self.view.frame.size.height - self.tabBar.frame.height
//        if UIDevice.current.iPhoneX {
//            UIRectFill(CGRect(origin: CGPoint(x: (size.width / 2.0) - (w / 2.0) ,y : 0 ), size: CGSize(width: w , height: lineHeight)))
//
//        }else{
//            UIRectFill(CGRect(origin: CGPoint(x: (size.width / 2.0) - (w / 2.0) ,y :  0 ), size: CGSize(width: w , height: lineHeight)))
//
//        }
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
  //      UIImage()
   // }
}
