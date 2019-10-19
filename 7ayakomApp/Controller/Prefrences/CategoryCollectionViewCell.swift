//
//  CategoryCollectionViewCell.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var catImage : UIImageView!
    @IBOutlet weak var catName : UILabel!
    @IBOutlet weak var isSelectedView : UIView!

    var images = [#imageLiteral(resourceName: "cat3") , #imageLiteral(resourceName: "cat4") , #imageLiteral(resourceName: "cat2") , #imageLiteral(resourceName: "cat1")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func setData(category : Category){
        if category.CategoryImagePath != ""{
            catImage.setShowActivityIndicator(true)
            catImage.setIndicatorStyle(.gray)
            catImage.sd_setImage(with: URL.init(string: category.CategoryImagePath))
        }else{
//            catImage.image = images[Int(arc4random_uniform(UInt32(images.count)))]
        }
        catName.text = category.CategoryName
        isSelectedView.isHidden = !category.IsFavourite
        isSelectedView.setNeedsLayout()
        isSelectedView.frame = catImage.frame
        isSelectedView.setNeedsLayout()
    }
    
}
