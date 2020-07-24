//
//  AddressesViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class AddressesViewModel: AddressesViewModelType{
    
    public var addressesModel: BehaviorRelay<[AddressInfoUser]> = BehaviorRelay(value: [])
    private let delegate = UIApplication.shared.delegate as! AppDelegate
   
    private weak var delegateAddress: AddressActionDelegate?
    private var auth: ErrorAuth? = nil
    var isEdit = false
    
    init(delegateAddress: AddressActionDelegate?, addresses: BehaviorRelay<[AddressInfoUser]>){
        self.delegateAddress = delegateAddress
        self.addressesModel = addresses
    }
    
    func numberOfRow(in section: Int) -> Int {
        return addressesModel.value.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> AddressCellViewModelType {
        return AddressCellViewModel(addressModel: addressesModel.value[indexPath.row], isSelect: isEdit, indexPath: indexPath, delegateAddress: delegateAddress)
    }
    
    func removeAddress(at indexPAth: IndexPath) {
        addressesModel.remove(at: indexPAth.row)
        
    }
    
    
    //MARK:- Request Remove Address
    func requestRemoveAddress(at indexPath: IndexPath, callback: @escaping (RequestComplite)->()){
        guard let id = addressesModel.value[indexPath.row].id else {
            callback(.error)
            return
        }
        
        InfoUserAPI.requstObjectInfoUser(type: AddressInfoUserModel.self, request: .deleteAddress(id: id), delegate: delegate) { [weak self] (value) in
            if let address = value{
                if let success = address.success, success{
                    self?.addressesModel.accept(address.data ?? [])
                    callback(.complite)
                }else{
                    if let error = address.error, error == ErrorAuth.Unauthorized.value{
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

public extension BehaviorRelay where Element: RangeReplaceableCollection {
    func remove(at index: Element.Index) {
        var newValue = value
        newValue.remove(at: index)
        accept(newValue)
    }
}
