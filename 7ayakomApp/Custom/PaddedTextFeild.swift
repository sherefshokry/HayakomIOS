//
//  PaddedTextFeild.swift
//  A3maly
//
//  Created by Nora Sayed on 10/10/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class PaddedTextFeild: UITextField {

    
    let padding = UIEdgeInsets(top: 0, left: 8 , bottom: 0, right: 8)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
