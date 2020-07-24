//
//  OtherViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class OtherViewModel: OtherViewModelType{
    
    private var dataModel = [OtherModelType]()
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    public var contacts: BehaviorRelay<ContactsModel?> = BehaviorRelay(value: nil)
    private var auth: ErrorAuth? = nil

    init(){
        dataModel = [OtherRedModel.bankets,
                     OtherRedModel.feedback,
                     OtherRedModel.invate,
                     OtherInfoModel.about,
                     OtherInfoModel.delivery,
                     OtherInfoModel.contacts,
                     OtherInfoModel.settings]
    }
    
    func numberOfRow(in section: Int) -> Int {
        return dataModel.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> OtherModelType {
        let data = dataModel[indexPath.row]
        switch data.typeCell {
        case .info:
            return OtherInfoCellViewModel(otherInfoModel: data as! OtherInfoModel)
        case .red:
            return OtherRedCellViewModel(otherRedModel: data as! OtherRedModel)
        }
    }
    
    func didSelect(at indexPath: IndexPath) -> OtherModelType {
        return dataModel[indexPath.row]
    }
    
    public func getListContacts(callback: @escaping (RequestComplite)->()){
        ContactsAPI.requstObjectCafe(type: ContactsModel.self, request: .contacts, delegate: delegate) { [weak self] (value) in
            if let contacts = value{
                if let success = contacts.success, success{
                    self?.contacts.accept(contacts)
                    callback(.complite)
                }else{
                    if let error = contacts.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
