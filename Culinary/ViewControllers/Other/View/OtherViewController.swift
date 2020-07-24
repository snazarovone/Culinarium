//
//  OtherViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OtherViewController: UIViewController {
    
    //PRIVATE
    var otherViewModel = OtherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func requestContacts(){
        otherViewModel.getListContacts { [weak self] (result) in
            switch result{
            case .complite:
                break;
            case .error:
                if self?.otherViewModel.getAuth() != nil{
                    //открываем форму авторизации
                    self?.logout()
                }
            }
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
    
    //MARK:- Get Info User
    private func getUserInfo() -> BehaviorRelay<UserInfo?>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.userInfo
        }else{
            let model: BehaviorRelay<UserInfo?> = BehaviorRelay(value: nil)
            return model
        }
    }
    
    //MARK:- AllDishes
    private func getAllDish() -> BehaviorRelay<[DishMainInfo]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.dishesMainInfo
        }else{
            let model: BehaviorRelay<[DishMainInfo]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    //MARK:- Get Chat
    private func getChatUser() -> BehaviorRelay<[Chat]>{
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            return tabBarVC.chatModel
        }else{
            let model: BehaviorRelay<[Chat]> = BehaviorRelay(value: [])
            return model
        }
    }
    
    //MARK:- Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == SegueID.fillFeedback.id{
            if let dvc = segue.destination as? FillFeedbackViewController{
                dvc.fillFeedbackViewModel = FillFeedbackViewModel(selectHeader: FillFeedbackHeader.aboutDelivery, listCafe: getListCafe(), idSelectCafe: nil, idSelectDish: nil, userInfo: getUserInfo(), dishesMainInfo: getAllDish())
                dvc.otherViewControllerDelegate = self
            }
            return
        }
        
        if let identifier = segue.identifier, identifier == SegueID.contacts.id{
            if let dvc = segue.destination as? ContactsViewController{
                dvc.contactsViewModel = ContactsViewModel(contactsModel: otherViewModel.contacts)
            }
            return
        }
        
    }
    
    //MARK:- deinit
    deinit {
        print("OtherViewController is deinit")
    }
}

extension OtherViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherViewModel.numberOfRow(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = otherViewModel.cellForRow(at: indexPath)
        switch cellData.typeCell {
        case .red:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.otherRed.identifire) as! OtherRedTableViewCell
            cell.dataRedCell = cellData as? OtherRedCellViewModelType
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellID.otherInfo.identifire) as! OtherInfoTableViewCell
            cell.dataInfoCell = cellData as? OtherInfoCellViewModelType
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = self.otherViewModel.didSelect(at: indexPath)
        if cellData.typeCell == .red{
            if let segueId = (cellData as! OtherRedModel).segueID{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: segueId.id, sender: nil)
                }
            }
        }else{
            if cellData.typeCell == .info, let segueId = (cellData as! OtherInfoModel).segue{
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: segueId.id, sender: nil)
                }
            }
        }
    }
    
}

extension OtherViewController: OtherViewControllerDelegate{
    func logout() {
        if let tabBarVC = self.navigationController?.parent as? TabBarViewController{
            tabBarVC.removeDataAuth()
            tabBarVC.logout()
        }
    }
}
