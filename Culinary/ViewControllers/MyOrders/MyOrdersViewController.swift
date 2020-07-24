//
//  MyOrdersViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MyOrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var ordersStBtn: [UIButtonDesignable]!
    
    //PUBLIC
    public var myOrderViewModel: MyOrdersViewModel!
    
    //PRIVATE
    private let disposeBag = DisposeBag()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private weak var tabBarVC: TabBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        getTabBarVC()
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 32.0, right: 0.0)
        subscribe()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- Subscribes
    private func subscribe(){
        myOrderViewModel.archivOrder.subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        myOrderViewModel.currentOrder.subscribe(onNext: { [weak self] (_) in
            self?.tableView.reloadData()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
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
    
    //MARK:- Request DetailOrder
    private func requestDetailOrder(at id: Int){
        showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        myOrderViewModel.requestDetailOrder(at: id) { [weak self] (result, detail) in
            
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            
            switch result{
            case .complite:
                if let detail = detail{
                    self?.performSegue(withIdentifier: SegueID.aboutOrder.id, sender: detail)
                }
            case .error:
                if self?.myOrderViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.tabBarVC.removeDataAuth()
                    self?.tabBarVC.logout()
                }
            }
        }
    }
    
    private func requestRepeatOrder(at id: Int){
        showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        myOrderViewModel.requestRepeatOrder(at: id) { [weak self] (result) in
            switch result{
            case .complite:
                //запросить корзину
                if let self = self{
                    let basket = self.tabBarVC.basketModel
                    self.myOrderViewModel.requestBasket(basket: basket) { [weak self] (result) in
                        
                        self?.removeAllOverlays()
                        self?.view.isUserInteractionEnabled = true
                        
                        switch result{
                        case .complite:
                            //переходим к корзине
                            self?.tabBarVC.selectedIndex = 3
                            self?.tabBarVC.setButtonStates(itemTag: 4)
                        case .error:
                            if self?.myOrderViewModel.getAuth() != nil{
                                //открываем форму регистрации
                                self?.tabBarVC.removeDataAuth()
                                self?.tabBarVC.logout()
                            }
                        }
                    }
                }
            case .error:
                
                self?.removeAllOverlays()
                self?.view.isUserInteractionEnabled = true
                
                if self?.myOrderViewModel.getAuth() != nil{
                    //открываем форму регистрации
                    self?.tabBarVC.removeDataAuth()
                    self?.tabBarVC.logout()
                }
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func stateOrders(_ sender: UIButtonDesignable) {
        for button in OrderTypes.allCases{
            if button.tag == sender.tag{
                myOrderViewModel.orderTypes = button
                
                ordersStBtn[button.tag-1].shadowColor = UIColor(named: "Red_550A0C") ?? .red
                ordersStBtn[button.tag-1].backgroundColor = UIColor(named: "RedA4262A") ?? .red
                ordersStBtn[button.tag-1].setTitleColor(.white, for: .normal)
            }else{
                ordersStBtn[button.tag-1].shadowColor = UIColor(named: "Black282A2F") ?? .black
                ordersStBtn[button.tag-1].backgroundColor = .white
                ordersStBtn[button.tag-1].setTitleColor(UIColor(named: "Black282A2F") ?? .black, for: .normal)
            }
        }
        tableView.reloadData()
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.aboutOrder.id{
            if let dvc = segue.destination as? AboutOrderViewController{
                dvc.aboutOrderViewModel = AboutOrderViewModel(detailOrder: sender as! HistoryDetail)
            }
        }
    }
    
    //MARK:- deinit
    deinit{
        print("MyOrdersViewController is deinit")
    }
}

extension MyOrdersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderViewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch myOrderViewModel.orderTypes {
        case .current:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.currentOrderInfo.identifire) as! CurrentOrderInfoTableViewCell
            cell.infoOrderDelegate = self
            cell.dataCell = myOrderViewModel.cellForRow(at: indexPath)
            return cell
            
            //                let cell = tableView.dequeueReusableCell(withIdentifier: CellID.currentOrderOnMap.identifire) as! CurrentOrderOnMapTableViewCell
                     //            return cell
            
        case .history:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.histOrder.identifire) as! HistOrderTableViewCell
            cell.dataHist = self.myOrderViewModel.cellForRowHist(at: indexPath)
            cell.historyOrderDelegate = self
            return cell
        }
    }
    
}

extension MyOrdersViewController: HistoryOrderDelegate{
    func aboutFromHistoryOrder(at id: Int?) {
        guard let id = id else {
            return
        }
        requestDetailOrder(at: id)
    }
    
    func repearOrder(at id: Int?) {
        guard let id = id else {
            return
        }
        requestRepeatOrder(at: id)
    }
    
}

extension MyOrdersViewController: InfoOrderDelegate{
    func aboutOrder(at id: Int?) {
        guard let id = id else {
            return
        }
        requestDetailOrder(at: id)
    }
    
    func cancelOrder() {
        print("cancel")
    }
    
}
