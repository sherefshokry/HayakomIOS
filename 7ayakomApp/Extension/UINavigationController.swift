//
//  UINavigationController.swift
//  Shezlong
//
//  Created by Nora on 9/14/17.
//  Copyright © 2017 Bluecrunch. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {

    open override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    
    
   
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop + 1]
            popToViewController(vc, animated: animated)
        }
    }

}
