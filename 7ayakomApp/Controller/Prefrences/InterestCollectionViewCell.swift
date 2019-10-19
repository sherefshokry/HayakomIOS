//
//  InterestCollectionViewCell.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var dotView : UIView!
    @IBOutlet weak var backView : UIView!
    @IBOutlet weak var maxWidth : NSLayoutConstraint!
    

    
    override func awakeFromNib() {
        self.maxWidth.constant = UIScreen.main.bounds.width - 10 * 2 - 10 * 2
    }
    
    func setData(text : String , selected : Bool){
        nameLbl.text =  "\t" + text + "\t"
        let textAttr = getDot(selected: selected)
        let text2 = NSMutableAttributedString().customWithFont(text + "   ", font: UIFont.init(name: AppFontName.regular, size: 16)!, color: Colors.appAccentColor)
        textAttr.append(text2)
        nameLbl.attributedText = textAttr
        dotView.isHidden = true
        selected ? setSelected() : setUnSelected()
    }
    
    func getDot(selected : Bool)->NSMutableAttributedString{
        if selected{
       return NSMutableAttributedString.init(string: " \u{2022} ", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25) , NSAttributedString.Key.strokeColor : Colors.appPrimeryColor , NSAttributedString.Key.strokeWidth : -1.0 , NSAttributedString.Key.foregroundColor : Colors.appPrimeryColor])
        }else{
            return  NSMutableAttributedString.init(string: " \u{2022} ", attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25) , NSAttributedString.Key.strokeColor : UIColor.init(codeString: "#8C9BA4") , NSAttributedString.Key.strokeWidth : -1.0 , NSAttributedString.Key.foregroundColor : UIColor.white])
        }
    }
    
    func setSelected(){
        dotView.backgroundColor = Colors.appPrimeryColor
        dotView.borderColor = Colors.appPrimeryColor
        backView.backgroundColor = UIColor.init(codeString: "#E5ECF1").withAlphaComponent(0.5)
        
        
    }
    
    func  setUnSelected() {
        dotView.backgroundColor = .white
        dotView.borderColor = Colors.appPrimeryColor
        backView.backgroundColor = UIColor.white
        
    }
}
