//
//  OrderAcceptedViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderAcceptedViewController: UIViewController {
    
    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var deliveryMethod: UILabel!
    @IBOutlet weak var addressDelivery: UILabel!
    @IBOutlet weak var timeDelivery: UILabel!
    @IBOutlet weak var totalSum: UILabel!
    @IBOutlet weak var coupon: UIView! //hide is default
    @IBOutlet weak var mailBtn: UIButton!
    
    
    //PUBLIC
    public var orderAcceptedViewModel: OrderAcceptedViewModel!
    
    //PRIVATE
    private let disposeBag = DisposeBag()
    private weak var tabBarVC: TabBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        getTabBarVC()
        subscribe()
        mailBtn.setTitle(mailUser, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func getTabBarVC(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
        
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                self.tabBarVC = tabBarVC
                return
            }
        }
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
            self.tabBarVC = tabBarVC
        }
    }
    
    private var mailUser: String{
        if let email = tabBarVC.userInfo.value?.email{
            return "почту \(email)"
        }else{
            return "почту"
        }
    }
    
    //MARK:- Subscribe
    private func subscribe(){
        orderAcceptedViewModel.confirmBasket.asObservable().subscribe(onNext: { [weak self] (value) in
            self?.numberOrder.text = self?.orderAcceptedViewModel.numberOrder
            self?.deliveryMethod.text = self?.orderAcceptedViewModel.deliveryMethod
            self?.addressDelivery.text = self?.orderAcceptedViewModel.address
            self?.timeDelivery.text = self?.orderAcceptedViewModel.time
            self?.totalSum.text = self?.orderAcceptedViewModel.sum
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Actions
    @IBAction func showCheck(_ sender: UIButton) {
    }
    
    @IBAction func sendCheckSms(_ sender: UIButton) {
    }
    
    @IBAction func openMain(_ sender: UIButton) {
        tabBarVC.selectedIndex = 0
        tabBarVC.setButtonStates(itemTag: 1)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    //MARK:- deinit
    deinit {
        print("OrderAcceptedViewController is deinit")
    }

}
