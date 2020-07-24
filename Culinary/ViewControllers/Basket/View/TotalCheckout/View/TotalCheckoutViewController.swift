//
//  TotalCheckoutViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 25.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftOverlays

class TotalCheckoutViewController: UIViewController {
    
    
    @IBOutlet weak var checkoutOrder: UIButtonDesignable!
    @IBOutlet weak var weightOrder: UILabel!
    @IBOutlet weak var countPortions: UILabel!
    @IBOutlet weak var sumOrder: UILabel!
    @IBOutlet weak var discont: UILabel!
    @IBOutlet weak var deliveryPrice: UILabel!
    @IBOutlet weak var toPay: UILabel!
    
    
    public var totalCheckoutViewModel: TotalCheckoutViewModel!
    private let disposeBag = DisposeBag()
    private weak var tabBarVC: TabBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribes()
        getTabBarVC()
    }
    
    private func subscribes(){
        totalCheckoutViewModel.basketCheckout.asObservable().subscribe(onNext: { [weak self] (value) in
            self?.weightOrder.text = self?.totalCheckoutViewModel?.weightOrder
            self?.countPortions.text = self?.totalCheckoutViewModel?.countPortions
            self?.sumOrder.text = self?.totalCheckoutViewModel?.sumOrder
            self?.discont.text = self?.totalCheckoutViewModel?.discont
            self?.deliveryPrice.text = self?.totalCheckoutViewModel?.deliveryPrice
            self?.toPay.text = self?.totalCheckoutViewModel?.toPay
            
            if value != nil && self?.totalCheckoutViewModel.idBasket != nil{
                self?.checkoutOrder.alpha = 1.0
                self?.checkoutOrder.isUserInteractionEnabled = true
            }else{
                self?.checkoutOrder.alpha = 0.5
                self?.checkoutOrder.isUserInteractionEnabled = false
            }
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
    
    
    //MARK:- Request Confirmation Order
    private func confirmOrder(){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        totalCheckoutViewModel.requestConfirmOrder { [weak self] (result) in
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                //обнуляем корзину
                self?.tabBarVC.basketModel.accept(nil)
                //перезапросить историю
                self?.tabBarVC.splashViewDelegate?.requestHistoryOrders()
                //переходим к чеку
                self?.performSegue(withIdentifier: SegueID.orderAccepted.id, sender: nil)
            case .error:
                if self?.totalCheckoutViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.tabBarVC.removeDataAuth()
                    self?.tabBarVC.logout()
                }else{
                    self?.alertWarning()
                }
            }
        }
    }
    
    private func alertWarning(){
        let alert = UIAlertController(title: "Ошибка", message: "Во время выполнения запроса произошла ошибка. Пожалуйста, попробуйте позднее", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.orderAccepted.id{
            if let dvc = segue.destination as? OrderAcceptedViewController{
                dvc.orderAcceptedViewModel = OrderAcceptedViewModel(confirmBasket: totalCheckoutViewModel.confirmBasket)
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func checkoutOrder(_ sender: UIButton){
        confirmOrder()
    }
    
    
    //MARK:- deinit
    deinit{
        print("TotalCheckoutViewController is deinit")
    }
    
}
