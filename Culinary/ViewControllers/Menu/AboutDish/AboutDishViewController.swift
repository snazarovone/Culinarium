//
//  AboutDishViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import TwitterProfile
import RxSwift
import RxCocoa

class AboutDishViewController: UIViewController, UIScrollViewDelegate {
    
    weak var headerVC: HeaderDishViewController?
    weak var vcs: DishXLPagerTabStrip?
    
    //PRIVATE
    private let refresh = UIRefreshControl()
    private weak var aboutDishBasketDelegate: AboutDishBasketDelegate?
    
    //PUBLIC
    public var dish: DisheModel!
    public var selectPortion: BehaviorRelay<PortionsDish?> = BehaviorRelay(value: nil)
    weak var dishMainDelegate: DishMainViewDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //implement data source to configure tp controller with header and bottom child viewControllers
        //observe header scroll progress with TPProgressDelegate
        self.tp_configure(with: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.layoutIfNeeded()
    }
    
    

    @objc func handleRefreshControl() {
        print("refreshing")
        if let headerVC = headerVC{
              headerVC.showGallery()
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.refresh.endRefreshing()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //MARK:- deinit
    deinit{
        print("deinit is AboutDishViewController")
    }
}

extension AboutDishViewController: TPDataSource, TPProgressDelegate{
    //MARK: TPDataSource
    func headerViewController() -> UIViewController {
        headerVC = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: "HeaderCatMenuViewController") as? HeaderDishViewController
      
        //dataSource
        headerVC?.dish = self.dish
        headerVC?.selectPortion = self.selectPortion
        
        headerVC?.endShow = {
            [weak self] in
            self?.refresh.endRefreshing()
        }
        self.aboutDishBasketDelegate = headerVC
        return headerVC!
    }
    
    
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        vcs = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: "DishXLPagerTabStrip") as? DishXLPagerTabStrip
        vcs?.dish = self.dish
        vcs?.dishMainDelegate = self.dishMainDelegate
        return vcs!
    }
    
    //headerHeight in the closed range [minValue, maxValue], i.e. minValue...maxValue
    func headerHeight() -> ClosedRange<CGFloat> {
        return (topInset + 152)...544
    }
    
    //MARK: TPProgressDelegate
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
        headerVC?.adjustBannerView(with: progress, headerHeight: headerHeight())
    }
    
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
        
        refresh.tintColor = .clear
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        let refreshView = UIView(frame: CGRect(x: 0, y: 44, width: 0, height: 0))
        scrollView.addSubview(refreshView)
        refreshView.addSubview(refresh)
        
    }
    
}

//MARK:- Basket Delegate
extension AboutDishViewController: AboutDishBasketDelegate{
    func inBasket(count: Int) {
        aboutDishBasketDelegate?.inBasket(count: count)
    }
}

