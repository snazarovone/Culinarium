//
//  CatMenuMainViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import TwitterProfile
import SwiftOverlays
import RxSwift
import RxCocoa

class CatMenuMainViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    
    //PRIVATE
    private weak var headerVC: HeaderCatMenuViewController?
    private weak var catMenuXLPagerTabStrip: CatMenuXLPagerTabStrip?
    
    private let refresh = UIRefreshControl()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //PUBLIC
    public var menuSection: MenuSection!
    public weak var menuViewControllerDelegate: MenuViewControllerDelegate?
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.layer.zPosition = 9999
        filterBtn.layer.zPosition = 9999
        
        self.tp_configure(with: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        self.catMenuXLPagerTabStrip?.reloadPagerTabStripView()
    }
    
    //MARK:- Request Menu by Filters
    private func requestMenuByFilter(){
        guard let idSection = menuSection.id else {return}
        
        let filtersId = getAllIdFilters()
        
        showWaitOverlay()
        self.view.isUserInteractionEnabled = false
   
        FiltersAPI.requstObjectFilters(type: MenuSectionDishes.self, request: .filters(section_id: idSection, id_filters: filtersId), delegate: delegate) { [weak self] (value) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            if let responce = value{
                if let success = responce.success, success{
                    //обновляем меню
                    self?.updateMenu(dataSectionWithDishes: responce.dataSectionWithDishes)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logOut()
                    }
                }
            }
        }
    }
    
    private func getAllIdFilters() -> String{
        var filtersId = ""
        for filter in menuSection.filters ?? []{
            for itemF in filter.values ?? []{
                if itemF.isSelect, let id = itemF.id{
                    filtersId += "\(id),"
                }
            }
        }
        if filtersId.count > 0{
            filtersId = String(filtersId.dropLast())
        }
        return filtersId
    }
    
    private func updateMenu(dataSectionWithDishes: [CatSectionMenu]?){
        guard let categories = dataSectionWithDishes else {
            return
        }
        menuSection.categories = categories
        catMenuXLPagerTabStrip?.categories = menuSection.categories ?? []
        
        self.catMenuXLPagerTabStrip?.reloadPagerTabStripView()
    }
    
    @objc func handleRefreshControl() {
        print("refreshing")
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.refresh.endRefreshing()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if delegate.didShowCatMenu == false{
            delegate.didShowCatMenu = true
            self.performSegue(withIdentifier: SegueID.alertPriceDelivery.id, sender: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK:- deinit
    deinit{
        print("CatMenuMainViewController is deinit")
    }
}

extension CatMenuMainViewController: TPDataSource, TPProgressDelegate{
    //MARK: TPDataSource
    func headerViewController() -> UIViewController {
        headerVC = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.headerCatMenu.identifier) as? HeaderCatMenuViewController
        headerVC?.titleCatSection = menuSection.title ?? ""
        headerVC?.filters = menuSection.filters ?? []
        headerVC?.isNewFilter = {[weak self] in
            self?.requestMenuByFilter()
        }
        return headerVC!
    }
    
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        catMenuXLPagerTabStrip = UIStoryboard.init(name: StoryboardsName.menu.name, bundle: nil).instantiateViewController(withIdentifier: ViewControllerID.catMenuXLPagerTabStrip.identifier) as? CatMenuXLPagerTabStrip
        catMenuXLPagerTabStrip?.categories = menuSection.categories ?? []
        catMenuXLPagerTabStrip?.catMenuMainDelegate = self
        catMenuXLPagerTabStrip?.favoritesDish = favoritesDish

        return catMenuXLPagerTabStrip!
    }
    
    //headerHeight in the closed range [minValue, maxValue], i.e. minValue...maxValue
    func headerHeight() -> ClosedRange<CGFloat> {
        return (topInset + 64)...200
    }
    
    //MARK: TPProgressDelegate
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
        headerVC?.adjustBannerView(with: progress, headerHeight: headerHeight())
    }
    
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
        
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        let refreshView = UIView(frame: CGRect(x: 0, y: 44, width: 0, height: 0))
        scrollView.addSubview(refreshView)
        refreshView.addSubview(refresh)
        
    }
    
}

extension CatMenuMainViewController: CatMenuMainDelegate{
    func showOverlay() {
        self.showWaitOverlay()
    }
    
    func removeOverlay() {
        self.removeAllOverlays()
    }
    
    func logOut() {
        self.menuViewControllerDelegate?.logout()
    }
}
