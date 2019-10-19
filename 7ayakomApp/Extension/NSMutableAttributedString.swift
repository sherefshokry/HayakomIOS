//
//  NSMutableAttributedString.swift
//  MyLexus
//
//  Created by Nora on 7/19/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    
    
    @discardableResult func customWithFont(_ text: String , font : UIFont , color  : UIColor) -> NSMutableAttributedString {
        let boldString = NSMutableAttributedString(string:text, attributes: [NSAttributedString.Key.font : font , NSAttributedString.Key.foregroundColor : color])
        append(boldString)
        
        return self
    }
}
