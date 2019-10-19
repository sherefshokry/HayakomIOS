//
//  EventsPager.swift
//  7IAKOM
//
//  Created by Nora Sayed on 11/21/18.
//  Copyright © 2018 Nora Sayed. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class EventsPager: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.init(codeString: "#F5B37B")
        settings.style.buttonBarItemFont = UIFont.init(name: AppFontName.regular , size: 12)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 10
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 20
        settings.style.buttonBarRightContentInset = 20
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.init(codeString: "#F5B37B").withAlphaComponent(0.4)
            newCell?.label.textColor = UIColor.init(codeString: "#F5B37B")
        }
        
        super.viewDidLoad()
        
        containerView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                        for controller in viewControllers
                        {
                            controller.view.transform =  CGAffineTransform(rotationAngle: CGFloat(Double.pi));
                            
                        }
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.buttonBarView.semanticContentAttribute = .forceRightToLeft
        self.containerView.semanticContentAttribute = .forceRightToLeft
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let allEvents = AllEventsViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        let goingEvents = GoingViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        let savedEvents = SavedEventsViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        let pastEvents = PastEventsViewController.instantiateFromStoryBoard(appStoryBoard: .Events)
        
        return [allEvents , goingEvents , savedEvents , pastEvents]
    }
    
}
