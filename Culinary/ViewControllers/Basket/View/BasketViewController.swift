//
//  BasketViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwipeCellKit
import RxSwift
import RxCocoa

class BasketViewController: UIViewController {
    
    @IBOutlet weak var emptyBasketView: UIView! //isHide default
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var viewPayments: UIView!
    
    private var basketViewModel: BasketViewModel!
    private var tap: UITapGestureRecognizer!
    private weak var basketDelegate: BasketDelegate?
    private let disposeBag = DisposeBag()
    private let delegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketViewModel = BasketViewModel(basketDataModel: getBasket())
        
        subscribes()
        basketDelegate = self
        
        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)

        showEmptyBasket()
        configKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func subscribes(){
        getBasket().subscribe(onNext: { [basketViewModel, tableView, showEmptyBasket, checkoutBtn] (_) in
            basketViewModel?.dataUpdate()
            tableView?.reloadData()
            showEmptyBasket()
            checkoutBtn?.setTitle(basketViewModel?.titleChekoutBtn, for: .normal)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    //MARK:- Get BasketModel
    private func getBasket() -> BehaviorRelay<BasketModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.basketModel
        }else{
            let model: BehaviorRelay<BasketModel?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- Get UserInfo
    private func getUserInfo() -> BehaviorRelay<UserInfo?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.userInfo
        }else{
            let model: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- Get MyAddress
    private func getMyAddress() -> BehaviorRelay<[AddressInfoUser]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.myAddresses
        }else{
            let model: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    //MARK:- Get List Cafe
    private func getListCafe() -> BehaviorRelay<CafeModel?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.listCafe
        }else{
            let model: BehaviorRelay<CafeModel?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    fileprivate func showEmptyBasket(){
        if basketViewModel.countDishInModel() > 0{
            emptyBasketView.isHidden = true
            viewPayments.isHidden = false
        }else{
            emptyBasketView.isHidden = false
            viewPayments.isHidden = true
        }
    }
    
    //MARK:- Request Quantity
    private func requestQuantityDishInBasket(idDishInBasket: Int, countProductInBasket: Int){
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .chageQuantity(item_id: idDishInBasket, quantity: countProductInBasket), delegate: delegate) { [weak self] (value, isCancel) in
            if let responce = value{
                if let success = responce.success, success{
                    self?.getBasket().accept(responce.data)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logout()
                    }else{
                        if isCancel{
                            return
                        }
                        if let error = responce.error{
                            self?.alertWarning(title: "Ошибка", message: error)
                        }
                        self?.getBasket().accept(self?.getBasket().value)
                    }
                }
            }
        }
    }
    
    //MARK:- Request Remove Dish
    private func requestRemoveDishInBasket(idDishInBasket: Int){
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .removeDishFromBasket(item_id: idDishInBasket), delegate: delegate) { [weak self] (value, isCancel) in
            if let responce = value{
                if let success = responce.success, success{
                    self?.getBasket().accept(responce.data)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logout()
                    }else{
                        if isCancel{
                            return
                        }
                        if let error = responce.error{
                            self?.alertWarning(title: "Ошибка", message: error)
                        }
                        self?.getBasket().accept(self?.getBasket().value)
                    }
                }
            }
        }
    }
    
    //MARK:- Request Update Extra
    private func requestUpdateExtraInBasket(idExtraInBasket: Int, countProductInBasket: Int){
        BasketAPI.requstObjectBasket(type: BasketDataModel.self, request: .updateExtra(extra_id: idExtraInBasket, quantity: countProductInBasket), delegate: delegate) { [weak self] (value, isCancel) in
            if let responce = value{
                if let success = responce.success, success{
                    self?.getBasket().accept(responce.data)
                }else{
                    if let error = responce.error, error == ErrorAuth.Unauthorized.value{
                        self?.logout()
                    }else{
                        if isCancel{
                            return
                        }
                        if let error = responce.error{
                            self?.alertWarning(title: "Ошибка", message: error)
                        }
                        self?.getBasket().accept(self?.getBasket().value)
                    }
                }
            }
        }
    }
    
    
    func logout() {
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            tabBarVC.removeDataAuth()
            tabBarVC.logout()
        }
    }
    
    private func alertWarning(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, id == SegueID.checkout.id{
            if let dvc = segue.destination as? CheckoutViewController{
                dvc.checkoutViewModel = CheckoutViewModel(userInfo: getUserInfo(), myAddresses: getMyAddress(), listCafe: getListCafe())
            }
            return;
        }
    }
    
    //MARK:- Actions
    @IBAction func buyOneClick(_ sender: UIButton){
        
    }
    
    @IBAction func checkout(_ sender: UIButton){
        self.performSegue(withIdentifier: SegueID.checkout.id, sender: nil)
    }
    
    //MARK:- deinit
    deinit{
        print("BasketViewController is deinit")
    }

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = self.basketViewModel.cellForRow(at: indexPath)
        switch dataCell.basketCellType {
        case .menuItems:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketMenuItem.identifire) as! BMenuItemTableViewCell
            cell.dataMenu = dataCell as? BMenuTableCellViewModelType
            cell.menuDelegate = basketDelegate as? MenuDelegate
            return cell
        case .gift:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketGift.identifire) as! BGiftTableViewCell
            cell.dataGift = dataCell as? BGiftCellViewModelType
            return cell
        case .countSelectDish:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketCountDish.identifire) as! BCountDishTableViewCell
            cell.dataCountDish = dataCell as? BCountDishViewModelType
            return cell
        case .dish:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketDish.identifire) as! BasketDishTableViewCell
            cell.dataDish = dataCell as? BasketDishCellViewModelType
            cell.delegate = self
            cell.basketDelegate = self
            return cell
        case .additionally:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketAdditionally.identifire) as! BAdditTableViewCell
            cell.basketExtraDelegate = self
            cell.dataAddit = dataCell as? BAdditCellViewModelType
            return cell
        case .notForget:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketNotForget.identifire) as! BNotForgetTableViewCell
            cell.dataNotForget = dataCell as? BNotForgetCellViewModelType
            return cell
        case .coupons:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.tabMainCoupons.identifire) as! CouponsTableViewCell
            cell.dataCoupons = dataCell as? CouponsTableCellViewModelType
            return cell
        case .promotional:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketPromotionalTableViewCell.identifire) as! BasketPromotionalTableViewCell
            cell.dataPromotinal = dataCell as? BasketPromotionalCellViewModelType
            return cell
        case .total:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.basketTotal.identifire) as! BasketTotalTableViewCell
            cell.dataTotal = dataCell as? BasketTotalCellViewModelType
            return cell
        }
    }
    
    //MARK:- Swipe To Remove
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "") { [weak self] (action, indexPath) in
            if let self = self{
                if let idDish = self.basketViewModel.remove(at: indexPath){
                    self.requestRemoveDishInBasket(idDishInBasket: idDish)
                }
                action.fulfill(with: .delete)
            
                self.basketViewModel.checkCountDish()
                self.showEmptyBasket()
                self.tableView.reloadData()
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "white_trash")
        deleteAction.backgroundColor = UIColor(named: "RedA4262A") ?? .red
        deleteAction.title = nil

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}

//MARK:- TextFiled Delegate
extension BasketViewController: UITextFieldDelegate{
    
    
    fileprivate func configKeyboard(){
        //dissmis keyboard
        tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.isEnabled = false
        //event свернуть клавиатуру если был тап в пустую область
        view.addGestureRecognizer(tap)
        registerForKeyboardNotification()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        tap.isEnabled = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tap.isEnabled = true
    }
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification){
            let userInfo = notification.userInfo!
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            
        var contentInset:UIEdgeInsets = self.tableView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            tableView.contentInset = contentInset
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { [weak self] in
                            if let self = self{
                                self.view.layoutIfNeeded()
                            }
                },
                           completion: { (_) in
            })
        }
        
        @objc func kbWillHide(_ notification: Notification){
            let userInfo = notification.userInfo!
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
//            tableView.contentOffset = CGPoint.zero
            tableView.contentInset =  UIEdgeInsets(top: 0.0, left: 0.0, bottom: 80.0, right: 0.0)
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { [weak self] in
                            if let self = self{
                                self.view.layoutIfNeeded()
                            }
                },
                           completion: { (_) in
            })
        }
        
    
    func removeNotificationKeyBoard(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
}

//MARK:- Delegates
extension BasketViewController: MenuDelegate{
    func didSelectMenu(at indexPath: IndexPath) {
        print(indexPath.row)
        self.basketViewModel.changeDataMenuDelegate(currentIndex: indexPath.row)
    }
}

extension BasketViewController: BasketQuantityDelegate{
    func addQuantity(at idDish: Int, count: Int) {
        requestQuantityDishInBasket(idDishInBasket: idDish, countProductInBasket: count)
    }
    
    func removeQuantity(at idDish: Int, count: Int) {
        requestQuantityDishInBasket(idDishInBasket: idDish, countProductInBasket: count)
    }
}

//MARK:- Delegate Extras
extension BasketViewController: BasketExtraDelegate{
    func changeExtraQuantity(at idExtra: Int, count: Int) {
        requestUpdateExtraInBasket(idExtraInBasket: idExtra, countProductInBasket: count)
    }
}
