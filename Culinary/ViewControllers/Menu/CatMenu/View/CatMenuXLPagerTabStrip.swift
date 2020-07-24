//
//  CatMenuXLPagerTabStrip.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import TwitterProfile
import XLPagerTabStrip
import RxSwift
import RxCocoa


class CatMenuXLPagerTabStrip: ButtonBarPagerTabStripViewController, PagerAwareProtocol {
    
    var categories = [CatSectionMenu]()
    weak var catMenuMainDelegate: CatMenuMainDelegate?
    
    //MARK: PagerAwareProtocol
    weak var pageDelegate: BottomPageDelegate?
    
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    
    var currentViewController: UIViewController?{
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
        settings.style.buttonBarBackgroundColor = UIColor(named: "Orange_F4AD24")!
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = UIColor(named: "Orange_B4760B")!
        settings.style.buttonBarItemTitleColor = .white
        settings.style.selectedBarHeight = 32
        settings.style.selectedBarVerticalAlignment = .middle
        settings.style.buttonBarItemFont = UIFont(name:"Rubik-Medium", size:14.0)!
    }
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buttonBarView.selectedBar.layer.cornerRadius = 6.0
        
        self.changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            oldCell?.label.textColor = .white
            oldCell?.layer.zPosition = 10000
          
            newCell?.label.textColor = .white
            newCell?.layer.zPosition = 10000
            newCell?.contentView.clipsToBounds = true
        }
    }
    
    private func createTabStrips() -> [UIViewController]{
        var vcs = [UIViewController]()
        for (i, cat) in categories.enumerated(){
            let vc = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.bottomCatMenu.identifier) as! CatMenuBottomViewController
            vc.pageIndex = i
            vc.pageTitle = cat.title
            vc.catMenuBottomViewModel = CatMenuBottomViewModel(dishes: cat.dishes ?? [], sectionId: cat.section_id ?? 0)
            vc.catMenuMainDelegate = catMenuMainDelegate
            vc.favoritesDish = favoritesDish
            vcs.append(vc)
        }
        return vcs
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return createTabStrips()
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
