//
//  ProfileViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwiftOverlays
import RxSwift
import RxCocoa
import VK_ios_sdk

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var countNewAnswer: UIButton!
    @IBOutlet weak var viewChangePassord: UIView! //hide when auth in social
    @IBOutlet weak var hello: UILabel! //trim "," in end if nameUser == nil
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var heightNameConst: NSLayoutConstraint!
    
    //PRIVATE
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private let disposeBag = DisposeBag()
   
    private var archivOrder: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    private var currentOrders: BehaviorRelay<[HistoryOrder]> = BehaviorRelay(value: [])
    
    //PUBlIC
    weak var tabMainDelegate: TabMainDelegate?
    public var myAddresses: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    public var userInfo: BehaviorRelay<UserInfo?> = BehaviorRelay(value: UserInfo())
    public var newsLetter: BehaviorRelay<NewsLetter> = BehaviorRelay(value: .notSubscribe)
    public var chatModel: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getHistory()
        //скрываем поле изменение пароля если вход был осуществлен через соцсеть
        if UserAuth.shared.socialId != nil{
            viewChangePassord.isHidden = true
        }else{
            viewChangePassord.isHidden = false
        }
        
        subscribes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func subscribes(){
        userInfo.asObservable().subscribe(onNext: { [weak self] (_) in
            self?.setupUserName()
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)

        chatModel.asObservable().subscribe(onNext: { [weak self] (chats) in
            //устанавливаем колличества всего непрочитанных сообщений
            var count = 0
            for chat in chats{
                for replies in chat.replies ?? []{
                    if replies.status == .unread{
                        count += 1
                    }
                }
            }

            if count == 0{
                self?.countNewAnswer?.isHidden = true
            }else{
                self?.countNewAnswer?.isHidden = false
                self?.countNewAnswer?.setTitle("\(count)", for: .normal)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
    private func getHistory(){
        guard let splashVC = UIApplication.shared.windows.first?.rootViewController as? SplashViewController else {return}
        
        for chieldVC in splashVC.children{
            if let tabBarVC = chieldVC as? TabBarViewController{
                self.archivOrder = tabBarVC.archivOrder
                self.currentOrders = tabBarVC.currentOrders
                return
            }
        }
        
        if let tabBarVC = splashVC.presentedViewController as? TabBarViewController{
            self.archivOrder = tabBarVC.archivOrder
            self.currentOrders = tabBarVC.currentOrders
        }
    }
    
    //MARK:- request Logiut
    private func requestLogout(){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        VKSdk.forceLogout()
        
        AuthAPI.requstAuthAPI(type: BaseResponseModel.self, request: .logout, delegate: delegate) { [weak self] (value) in
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            if let value = value{
                if let success = value.success, success{
                    //выход
                    self?.tabMainDelegate?.logout()
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        //выход
                        self?.tabMainDelegate?.logout()
                    }
                    else{
                        if let error = value.error{
                            self?.showAlert(message: error)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- Get User Accounts
    private func requestUserAccounts(){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        InfoUserAPI.requstObjectInfoUser(type: UserAccountsModel.self, request: .userAccounts, delegate: delegate) { [weak self] (value) in
            self?.removeAllOverlays()
            self?.view.isUserInteractionEnabled = true
            if let value = value{
                if let success = value.success, success{
                    //переходим на экран социальные сети
                    self?.performSegue(withIdentifier: SegueID.social.id, sender: value)
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        //выход
                        self?.tabMainDelegate?.logout()
                    }
                    else{
                        if let error = value.error{
                            self?.showAlert(message: error)
                        }
                    }
                }
            }
        }
    }
    
    //MARK:- Request Get MyOrders
    private func requestMyOrders(){
        self.showWaitOverlay()
        self.view.isUserInteractionEnabled = false
        
        HistoryAPI.requstHistoryBasket(type: HistoryOrderModel.self, request: .archive, delegate: delegate) { [weak self] (value, _) in
            
            if let value = value{
                if let success = value.success, success{
                    self?.archivOrder.accept(value.data ?? [])
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        //выход
                        self?.tabMainDelegate?.logout()
                    }
                }
            }
            
            
            if let self = self{
                HistoryAPI.requstHistoryBasket(type: HistoryOrderModel.self, request: .curentOrders, delegate: self.delegate) { [weak self] (value, _) in
                    self?.removeAllOverlays()
                    self?.view.isUserInteractionEnabled = true
                 
                    if let value = value{
                        if let success = value.success, success{
                            self?.currentOrders.accept(value.data ?? [])
                        }else{
                            if let error = value.error, error == ErrorAuth.Unauthorized.value{
                                //выход
                                self?.tabMainDelegate?.logout()
                                return;
                            }
                        }
                    }
                    self?.performSegue(withIdentifier: SegueID.myOrder.id, sender: nil)
                }
            }else{
                self?.removeAllOverlays()
                self?.view.isUserInteractionEnabled = true
            }
        }
    }
    
    private func showAlert(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.addresses.id{
            if let dvc = segue.destination as? AddressesViewController{
                dvc.myAddresses = self.myAddresses
                dvc.setLogout = {
                    [weak self] in
                    self?.tabMainDelegate?.logout()
                }
            }
            return
        }
        
        if let identifier = segue.identifier, identifier ==  SegueID.personalInformation.id{
            if let dvc = segue.destination as? PersonalInformationViewController{
                dvc.personalInfoViewModel = PersonalInfoViewModel(userInfoData: self.userInfo)
                dvc.setLogout = {
                    [weak self] in
                    self?.tabMainDelegate?.logout()
                }
            }
            return
        }
        
        if let identifier = segue.identifier, identifier ==  SegueID.mailing.id{
            if let dvc = segue.destination as? MailingViewController{
                dvc.newsLetter = self.newsLetter
                dvc.setLogout = {
                    [weak self] in
                    self?.tabMainDelegate?.logout()
                }
            }
            return
        }
        
        //MARK:- chat
        if let identifier = segue.identifier, identifier ==  SegueID.dialogs.id{
            if let dvc = segue.destination as? DialogsViewController{
                dvc.dialogsViewModel = DialogsViewModel(chatModel: chatModel, userInfo: userInfo.value)
            }
            return
        }
        
        //MARK:- SocialNet
        if let identifier = segue.identifier, identifier ==  SegueID.social.id{
            if let dvc = segue.destination as? SocialViewController, let socialData = sender as? UserAccountsModel{
                dvc.socialData = socialData
            }
            return
        }
        
        //MARK:- MyOrders
        if let identifier = segue.identifier, identifier ==  SegueID.myOrder.id{
            if let dvc = segue.destination as? MyOrdersViewController{
                dvc.myOrderViewModel = MyOrdersViewModel(archivOrder: self.archivOrder, currentOrder: self.currentOrders)
            }
            return
        }
    }
    
    //MARK:- Setup UserName
    private func setupUserName(){
        guard let userInfo = userInfo.value else {
            styleHello(is: false, text: "Здраствуйте")
            heightNameConst.constant = 0.0
            return
        }
        
        if let name = userInfo.name, name.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
            if let surname = userInfo.surname, surname.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                nameUser.text = "\(name) \(surname)"
            }else{
                nameUser.text = "\(name)"
            }
            styleHello(is: true, text: "Здраствуйте,")
            heightNameConst.constant = 26.5
        }else{
           if let surname = userInfo.surname, surname.trimmingCharacters(in: .whitespacesAndNewlines).count > 0{
                nameUser.text = "\(surname)"
                styleHello(is: true, text: "Здраствуйте,")
                heightNameConst.constant = 26.5
            }else{
                nameUser.text = nil
                styleHello(is: false, text: "Здраствуйте")
            heightNameConst.constant = 0.0
            }
        }
        
    }
    
    private func styleHello(is small: Bool, text: String){
        if small{
            let attributedString = NSAttributedString(string: "\(text)", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.208, green:0.218, blue:0.242, alpha:1.0),NSAttributedString.Key.font:UIFont(name:"Rubik-Regular", size:15.0)!])
            hello.attributedText = attributedString
        }else{
            let attributedString = NSAttributedString(string: "\(text)", attributes:[NSAttributedString.Key.foregroundColor:UIColor(red:0.208, green:0.218, blue:0.242, alpha:1.0),NSAttributedString.Key.font:UIFont(name:"Rubik-Bold", size:22.0)!])
            hello.attributedText = attributedString
        }
    }
    
    //MARK:- Actions
    @IBAction func dialogs(_ sender: UIButton){
        performSegue(withIdentifier: SegueID.dialogs.id, sender: nil)
    }
    
    @IBAction func personalInformation(_ sender: UIButton) {
        performSegue(withIdentifier: SegueID.personalInformation.id, sender: nil)
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        performSegue(withIdentifier: SegueID.changePassword.id, sender: nil)
    }
    
    @IBAction func mailing(_ sender: UIButton) {
        performSegue(withIdentifier: SegueID.mailing.id, sender: nil)
    }
    
    @IBAction func addresses(_ sender: UIButton) {
        performSegue(withIdentifier: SegueID.addresses.id, sender: nil)
    }
    
    @IBAction func social(_ sender: UIButton) {
        requestUserAccounts()
    }
    
    @IBAction func myOrders(_ sender: UIButton) {
        requestMyOrders()
    }
    
    @IBAction func logout(_ sender: UIButton) {
        requestLogout()
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- deinit
    deinit{
        print("ProfileViewController is deinit")
    }
}
