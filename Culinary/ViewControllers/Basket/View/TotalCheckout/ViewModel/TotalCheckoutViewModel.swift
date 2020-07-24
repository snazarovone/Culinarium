//
//  TotalCheckoutViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class TotalCheckoutViewModel{
    
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    public let basketCheckout: BehaviorRelay<BasketCheckout?>
    public var confirmBasket: BehaviorRelay<BasketConfirm?> = BehaviorRelay(value: nil)
    
    init(basketCheckout: BehaviorRelay<BasketCheckout?>){
        self.basketCheckout = basketCheckout
    }
    
    //MARK:- Request Confirmation Order
    func requestConfirmOrder(callback: @escaping (RequestComplite)->()){
        BasketAPI.requstObjectBasket(type: BasketConfirmModel.self, request: .confirmCheckout(cart_id: idBasket!), delegate: delegate) { [weak self] (value, _) in
            if let confirm = value{
                if let success = confirm.success, success{
                    self?.confirmBasket.accept(confirm.data)
                    callback(.complite)
                }else{
                    if let error = confirm.error, error == ErrorAuth.Unauthorized.value{
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

extension TotalCheckoutViewModel: TotalCheckoutViewModelType{
    var weightOrder: String {
        if let value = basketCheckout.value?.weight{
            return "\(value) гр."
        }
        return " "
    }
    
    var countPortions: String {
        if let value = basketCheckout.value?.portions{
            return value.portions()
        }
        return " "
    }
    
    var sumOrder: String {
        if let value = basketCheckout.value?.sum{
            return "\(value) ₽"
        }
        return " "
    }
    
    var discont: String {
        if let value = basketCheckout.value?.discount{
            return "\(value) ₽"
        }
        return " "
    }
    
    var deliveryPrice: String {
        if let value = basketCheckout.value?.delivery{
            return "\(value) ₽"
        }
        return " "
    }
    
    var toPay: String {
        if let value = basketCheckout.value?.total_sum{
            return "\(value)"
        }
        return " "
    }
    
    var idBasket: Int?{
        return basketCheckout.value?.id
    }
}
