//
//  SelectCategoriesViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/20/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit
import KVNProgress
import hkAlium

class SelectCategoriesViewController: UIViewController  {

    @IBOutlet weak var collectionView : UICollectionView!
    
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return collectionView.collectionViewLayout as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    
    var list = [Category]()
    var heights : [Int] = [300 , 190 , 250]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 2
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        let dataSource = PrefrencesDataSource()
        KVNProgress.show()
        dataSource.getCategories { (status, response) in
            KVNProgress.dismiss()
            switch status{
            case .sucess :
                self.list = response as? [Category] ?? [Category]()
                self.collectionView.reloadData()
                break
            case .error :
                self.showMessage((response as? String)!)
                break
            case .networkError :
                self.showMessage((response as? String)!)
                break
            }
        }
    }
    
    @IBAction func save (_ sender : Any){
        let vc = InterestsViewController.instantiateFromStoryBoard(appStoryBoard: .Prefrences)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
extension SelectCategoriesViewController : UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell
        cell?.setData(category: list[indexPath.item])
        return cell!
    }
}
extension SelectCategoriesViewController : UICollectionViewDelegate {
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        list[indexPath.item].IsFavourite = !list[indexPath.item].IsFavourite
        collectionView.reloadData()
    }
}
extension SelectCategoriesViewController : CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForItemAt
        indexPath: IndexPath,
                        with width: CGFloat) -> CGFloat {
        
        return CGFloat(heights[Int(arc4random_uniform(UInt32(heights.count)))])
    }
}
//extension SelectCategoriesViewController : UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize.init(width: Int((self.view.frame.width - 48.0) / 2.0 )  , height: heights[Int(arc4random_uniform(UInt32(heights.count)))])
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//    }
//}
