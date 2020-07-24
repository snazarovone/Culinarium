//
//  TabBarViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 02.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import VK_ios_sdk
import MapKit

class TabBarViewController: UITabBarController {
    
    public var menuSections: MenuSectionsModel?
    public var myAddresses: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    public var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
    public var newsLetter: BehaviorRelay<NewsLetter> = BehaviorRelay(value: .notSubscribe)
    public var listCafe: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
    public var dishesMainInfo: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
    public var locationManager = CLLocationManager()
    public var basketModel: BehaviorRelay<BasketModel?> = BehaviorRelay(value: nil)
    public var archivOrder: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    public var currentOrders: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    public weak var splashViewDelegate: SplashViewDelegate?
    public var stocks: BehaviorRelay<StocksModel?> = BehaviorRelay(value: nil)
    
    //PRIVATE
    private var fd : BehaviorRelay<MenuSectionsModel?> = BehaviorRelay(value: nil)
    private let disposeBag = DisposeBag()
    
    public var favoritesDish: BehaviorRelay<MenuSectionsModel?> {
        get {
            return fd
        }
        set {
            self.fd = newValue
        }
    }
    public var chatModel: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    
    //choose normal and selected fonts here
    let normalTitleFont = UIFont(name: "Rubik-Medium", size: 11.0)!
    let selectedTitleFont = UIFont(name: "Rubik-Medium", size: 11.0)!
    
    //choose normal and selected colors here
    //UIColor(named: "UITabBarUnselectTitle")!
    let normalTitleColor : UIColor = UIColor(named: "UITabBarUnselectTitle")!
    let selectedTitleColor : UIColor = UIColor(named: "UITabBarSelectTitle")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        
    }
    
    //the following is a delegate method from the UITabBar protocol that's available
    //to UITabBarController automatically. It sends us information every
    //time a tab is pressed. Since we Tagged our tabs earlier, we'll know which one was pressed,
    //and pass that identifier into a function to set our button states for us
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setButtonStates(itemTag: item.tag)
    }
    
    //MARK:- Subscribes
    //устанавливаем красную точку на иконке корзины если корзина не пустая
    private func subscribe(){
        basketModel.asObservable().subscribe(onNext: { [weak self] (value) in
            if let self = self, let items = value?.items, items.count > 0{
                self.tabBar.items?[3].image = UIImage(named: "BasketRedDot")
            }else{
                self?.tabBar.items?[3].image = UIImage(named: "Basket")
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    //the function takes the tabBar.tag as an Int
    func setButtonStates (itemTag: Int) {
        
        //making an array of all the tabs
        let tabs = self.tabBar.items
        
        //looping through and setting the states
        var x = 0
        while x < (tabs?.count)! {
            
            if tabs?[x].tag == itemTag {
                tabs?[x].setTitleTextAttributes([NSAttributedString.Key.font: selectedTitleFont, NSAttributedString.Key.foregroundColor: selectedTitleColor], for: UIControl.State.normal)
            } else {
                tabs?[x].setTitleTextAttributes([NSAttributedString.Key.font: normalTitleFont, NSAttributedString.Key.foregroundColor: normalTitleColor], for: UIControl.State.normal)
            }
            
            x += 1
            
        }
        
    }
    
    func logout(){
        dismiss(animated: true, completion: nil)
    }
    
    public func removeDataAuth(){
        UserAuth.shared = UserAuth()
        UserDefaults.standard.removeObject(forKey: UDID.dataLogin.key)
        VKSdk.forceLogout()
    }
    
    deinit{
        print("TabBarViewController is deinit")
    }
}
