//
//  CheckoutViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 17.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class CheckoutViewModel{
    
    public let userInfo: BehaviorRelay<UserInfo?>
    public let myAddresses: BehaviorRelay<[AddressInfoUser]>
    public let listCafe: BehaviorRelay<CafeModel?>
    public var basketCheckout: BehaviorRelay<BasketCheckout?> = BehaviorRelay(value: nil)
    
    public var selectAddress: AddressInfoUser?
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    public var idSelectCafe: Int?
    public var deliveryType: DeliveryType = .courier
    public var paymentType: PaymentType = .cash
    
    
    init(userInfo: BehaviorRelay<UserInfo?>,
         myAddresses: BehaviorRelay<[AddressInfoUser]>,
         listCafe: BehaviorRelay<CafeModel?>){
        self.userInfo = userInfo
        self.myAddresses = myAddresses
        self.listCafe = listCafe
    }
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X(XXX) XXX-XX-XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    var phoneUser: String?{
        if let phone =  userInfo.value?.phone{
            return formattedNumber(number: phone)
        }
        return nil
    }
    
    
    //MARK:- Request Checkout Order
    public func requestCheckoutOrder(name: String, phone: String, time: String, title: String?, street: String?, house: String?, porch: String?, flat: String?, door_code: String?, floor: Int?, exchange: Int?, callback: @escaping (RequestComplite)->()){
        
        
        BasketAPI.requstObjectBasket(type: BasketCheckoutModel.self, request: .checkout(name: name, phone: phone, order_time: time, delivery_type_id: deliveryType, payment_type_id: paymentType, delivery_address_id: idSelectedAddress, title: title, street: street, house: house, porch: porch, flat: flat, door_code: door_code, floor: floor, cafe_id: idSelectCafe, exchange: exchange), delegate: delegate) { [weak self] (value, _) in
            if let basket = value{
                if let success = basket.success, success{
                    self?.basketCheckout.accept(basket.data)
                    callback(.complite)
                }else{
                    if let error = basket.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
        
    }
}

extension CheckoutViewModel: CheckoutViewModelType{
    func numberOfRow() -> Int {
        return myAddresses.value.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SaveAddressCellViewModelType {
        return SaveAddressCellViewModel(addressInfoUser: myAddresses.value[indexPath.row])
    }
    
    func didSelect(at indexPath: IndexPath) {
        selectAddress = self.myAddresses.value[indexPath.row]
    }
    
    var heightListMyAddress: CGFloat{
        let countAddress = myAddresses.value.count
        if countAddress > 5{
            return CGFloat(320)
        }
        else{
            return CGFloat(countAddress * 64)
        }
    }
    
    var titleSelectAddress: String?{
        return selectAddress?.title
    }
    
    var street: String?{
        return selectAddress?.street
    }
    
    var house: String?{
        return selectAddress?.house
    }
    
    //этаж
    var floor: String?{
        if let f = selectAddress?.floor{
            return "\(f)"
        }else{
            return nil
        }
    }
    
    var flat: String?{
        return selectAddress?.flat
    }
    
    //подъезд
    var porch: String?{
        return selectAddress?.porch
    }
    
    var doorcode: String?{
        return selectAddress?.door_code
    }
    
    var idSelectedAddress: Int?{
        return selectAddress?.id
    }
    
    func removeSelectedAddress(){
        self.selectAddress = nil
    }
    
    //проверка существования адреса
    func checkExistSelectedAddress() -> Bool {
        guard let selectedAddress = selectAddress else {
            removeSelectedAddress()
            return false
        }
        
        for address in myAddresses.value{
            if let idAddress = address.id, let idSelected = selectedAddress.id, idSelected == idAddress{
                return true
            }
        }
        removeSelectedAddress()
        return false
    }
    
    func checkExistAddress(street: String?, house: String?, porch: String?, flat: String?, floor: String?, doorCode: String?) -> Bool{

        var streetAddress: String? = nil
        if let street = street{
            streetAddress = street.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var houseAddress: String? = nil
        if let house = house{
            houseAddress = house.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var porchAddress: String? = nil
        if let porch = porch{
            porchAddress = porch.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var flatAddress: String? = nil
        if let flat = flat{
            flatAddress = flat.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var floorAddress: String? = nil
        if let floor = floor{
            floorAddress = floor.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        var doorCodeAddress: String? = nil
        if let doorCode = doorCode{
            doorCodeAddress = doorCode.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        for address in myAddresses.value{
            if (address.street ?? "") == streetAddress,
                (address.house ?? "") == houseAddress,
                (address.porch ?? "") == porchAddress,
                (address.flat ?? "") == flatAddress,
                (address.door_code ?? "") == doorCodeAddress{
                var fl : String = ""
                if let f = address.floor{
                    fl = "\(f)"
                }
                if fl == floorAddress{
                    selectAddress = address
                    return true
                }
            }
        }
        return false
    }
    
    public func nameSelectCafe() -> String?{
        guard let idSelectCafe = idSelectCafe, let listCafe = listCafe.value else{
            return ""
        }
        for cafe in listCafe.cafes ?? []{
            if let id = cafe.id, id == idSelectCafe{
                return cafe.title
            }
        }
        return ""
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
    
}
