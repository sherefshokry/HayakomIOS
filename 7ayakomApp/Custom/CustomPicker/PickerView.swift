//
//  PickerView.swift
//  Feed
//
//  Created by Nora on 5/14/18.
//  Copyright © 2018 Nora. All rights reserved.
//

import UIKit

protocol PickerViewDelegate {
    func doneSelecting(index : Int)
    func doneSelecting(indexs : [Int])
    
}

extension PickerViewDelegate {
    func doneSelecting(index : Int){}
    func doneSelecting(indexs : [Int]){}
}

class PickerView: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var titleView : UIView!
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var subTitleLbl : UILabel!
    @IBOutlet weak var doneBtn : UIButton!
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    
    var cellIdentifer = "PickerCell"
    var doneBtnTitle = ""
    var cancelBtnTitle = ""
    var cancelBtnColor = UIColor.lightGray
    var cancelBtnFontColor = UIColor.white
    var btnsFontColor = UIColor.white
    var primaryColor = UIColor.white
    var listTextColor = UIColor.black
    var accentColor = UIColor.red
    var titleText = ""
    var subTitleText = ""
    var titleTextColor = UIColor.white
    var listSource = [String]()
    var selectedIndex = -1
    var listSourceStatus:[Bool] = []
    var selectedIndexes = [Int]()
    var pickerDelegate :PickerViewDelegate!
    var mood: CustomPickerViewMoods = .SINGLE_CHOICE {
        didSet{
            if mood == .SINGLE_CHOICE{
                cellIdentifer = "PickerCell"
            }else{
                cellIdentifer = "PickerCell"
            }
            let nib = UINib.init(nibName: cellIdentifer, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        let nib = UINib.init(nibName: cellIdentifer, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifer)
        setCustomizations()
        showAnimate()
        
        
    }
    
    func setCustomizations(){
        if(mood != .SINGLE_CHOICE)
        {
            self.bottomHeight.constant = 66
            for (index , item)  in listSource.enumerated()
            {
                listSourceStatus.append(selectedIndexes.contains(index))
            }
            
        }
        
        titleLbl.text = titleText
        subTitleLbl.text = subTitleText
        tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender : Any){
        
        if(mood == .SINGLE_CHOICE)
        {
            if pickerDelegate != nil && selectedIndex != -1 {
                
            }
            removeAnimate(funcToLoad: {self.pickerDelegate.doneSelecting(index: self.selectedIndex)})
        }else{
            if pickerDelegate != nil {
                var selectedIndexes:[Int] = []
                var count = 0
                for source in self.listSourceStatus
                {
                    if(source)
                    {
                        selectedIndexes.append(count)
                    }
                    count = count+1
                }
               
            }
            removeAnimate(funcToLoad:  {self.pickerDelegate.doneSelecting(indexs: self.selectedIndexes)})
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender : Any){
        removeAnimate(funcToLoad: {})
    }
    
    
    func showAnimate()
    {
        let orignalFrame = self.cardView.frame
        let oldframe = CGRect.init(x: 0, y: self.view.frame.height , width: self.view.frame.height , height: cardView.frame.height)
        cardView.frame = oldframe
        UIView.animate(withDuration: 0.5 , delay: 0.1 , options: .transitionFlipFromBottom, animations: {
            self.view.alpha = 1.0
            self.cardView.frame = orignalFrame
        }) { (finished : Bool) in
            if(finished)
            {
                
            }
        }
    }
    
    
    func removeAnimate(funcToLoad : @escaping (()->()))
    {
        UIView.animate(withDuration: 0.5 , delay: 0.1 , options: .transitionFlipFromTop, animations: {
            self.view.alpha = 0.0
            self.cardView.frame = CGRect.init(x: 0, y: self.view.frame.height , width: self.view.frame.height , height: self.cardView.frame.height)
        }) { (finished : Bool) in
            if(finished)
            {   funcToLoad()
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        }
        
    }
    
    
}
extension PickerView : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(mood == .SINGLE_CHOICE)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? PickerCell
       
            cell?.setData(title: listSource[indexPath.row], image: "", selected: selectedIndex == indexPath.row)
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer) as? PickerCell
            cell?.setData(title: listSource[indexPath.row], image: "", selected: listSourceStatus[indexPath.row])
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(mood == .SINGLE_CHOICE)
        {
            selectedIndex = indexPath.row
            doneButtonPressed(self)
        }else{
            listSourceStatus[indexPath.row] = !listSourceStatus[indexPath.row]
        }
        tableView.reloadData()
    }
    
}
