//
//  UIScrollView.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView{
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}
