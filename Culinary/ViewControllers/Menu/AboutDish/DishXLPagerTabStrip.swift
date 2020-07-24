//
//  DishXLPagerTabStrip.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import TwitterProfile
import XLPagerTabStrip
import RxSwift
import RxCocoa


class DishXLPagerTabStrip: ButtonBarPagerTabStripViewController, PagerAwareProtocol {
    
    //MARK: PagerAwareProtocol
    var pageDelegate: BottomPageDelegate?
    var dish: DisheModel!
    weak var dishMainDelegate: DishMainViewDelegate?
    
    
    weak var currentViewController: UIViewController?{
        return viewControllers[currentIndex]
    }
    
    
    var pagerTabHeight: CGFloat?{
        return 56
    }
    
    //MARK: Properties
    var isReload = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settings.style.buttonBarRightContentInset = 32.0
        settings.style.buttonBarLeftContentInset = 32.0
        settings.style.buttonBarBackgroundColor = UIColor(named: "Main")!
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(named: "RedA4262A")!
        settings.style.buttonBarItemTitleColor = UIColor(named: "282A2F_50")
        settings.style.selectedBarHeight = 2
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarItemFont = UIFont(name:"Rubik-Medium", size:14.0)!
    }
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        delegate = self

        self.changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            oldCell?.label.textColor = UIColor(named: "282A2F_50")
          
            newCell?.label.textColor = UIColor(named: "RedA4262A")!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.layoutIfNeeded()
    }
    
    deinit{
        print("DishXLPagerTabStrip is deinit")
    }
    
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        var vcs = [UIViewController]()
        
        let vc1 = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.dishDescription.identifier) as! DishDescriptionViewController
        vc1.pageIndex = 0
        vc1.pageTitle = "ОПИСАНИЕ"
        vc1.descriptionDish = dish.description ?? ""
        vcs.append(vc1)

        let vc2 = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.dishConsist.identifier) as! DishConsistViewController
              vc2.pageIndex = 1
              vc2.pageTitle = "СОСТАВ"
        vc2.consist = dish.consist ?? ""
        vcs.append(vc2)
        
        if let id = dish.id{
            let vc3 = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.dishFeedback.identifier) as! DishFeedbackViewController
            vc3.pageIndex = 2
            vc3.pageTitle = "ОТЗЫВЫ"
            vc3.dishFeedbackViewModel = DishFeedbackViewModel(dishId: id)
            vc3.dishMainDelegate = self.dishMainDelegate
            vcs.append(vc3)
        }
        return vcs
    }
    
    override func reloadPagerTabStripView() {
        pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        super.reloadPagerTabStripView()
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        guard indexWasChanged == true else { return }
        
        //IMPORTANT!!!: call the following to let the master scroll controller know which view to control in the bottom section
        self.pageDelegate?.tp_pageViewController(self.currentViewController, didSelectPageAt: toIndex)
        
    }
}
