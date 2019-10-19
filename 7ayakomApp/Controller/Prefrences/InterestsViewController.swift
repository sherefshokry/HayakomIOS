//
//  InterestsViewController.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/23/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController {

    let TAGS = ["Tech", "Design", "Humor", "Travel", "Music", "Writing", "Social Media", "Life", "Education", "Edtech", "Education Reform", "Photography", "Startup", "Poetry", "Women In Tech", "Female Founders", "Business", "Fiction", "Love", "Food", "Sports"]
    
    public var flowLayout: tagViewLayOut? {
        get {
            return collectionView.collectionViewLayout as? tagViewLayOut
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    
    var selected = [Int]()
    var sizingCell: InterestCollectionViewCell?

    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "InterestCollectionViewCell", bundle: nil)
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! InterestCollectionViewCell?
        collectionView.register(cellNib, forCellWithReuseIdentifier: "InterestCollectionViewCell")
        self.flowLayout?.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.collectionView.semanticContentAttribute = .forceRightToLeft
    }

}

extension InterestsViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TAGS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        cell.setData(text: TAGS[indexPath.item], selected: selected.contains(indexPath.item))
        return cell
    }
    
}
extension InterestsViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selected.contains(indexPath.item){
            if let index = selected.firstIndex(of: indexPath.item) {
                selected.remove(at: index )
            }
        }else{
            selected.append(indexPath.item)
        }
        collectionView.reloadData()
    }
}

extension InterestsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell?.setData(text: TAGS[indexPath.item], selected: selected.contains(indexPath.item))
       let w = self.sizingCell!.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        return CGSize.init(width: w, height: 40)
    }
}
