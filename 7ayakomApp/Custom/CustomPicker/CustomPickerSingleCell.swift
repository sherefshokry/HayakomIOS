//
//  CustomPickerSingleCell.swift
//  A3maly
//
//  Created by Nora Sayed on 10/12/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class CustomPickerSingleCell: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var container : CardView!
    
    
    func setData(title : String  ,  selected : Bool){
        titleLbl.text = title
        if selected {
            select()
        }else{
            unSelect()
        }

    }
    
    func select() {
        container.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.7176470588, blue: 0.8980392157, alpha: 1)
        container.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titleLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        container.layoutSubviews()
    }
    
    func unSelect()  {
        container.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        container.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        titleLbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.7176470588, blue: 0.8980392157, alpha: 1)
        container.layoutSubviews()
    }
    
}
