//
//  AllSidsCardView.swift
//  MyLexus
//
//  Created by Nora Sayed on 7/22/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

class AllSidsCardView: UIView {
    @IBInspectable var shadowOffset: CGFloat = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
//        layer.cornerRadius = cornerRadius
//        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//
//        layer.masksToBounds = false
//        layer.shadowColor = shadowColor?.cgColor
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = shadowPath.cgPath
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 4
//        view.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect.init(x: -shadowOffset / 2,
                                                   y: -shadowOffset / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = shadowPath.cgPath
    }
    

}
