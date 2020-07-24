//
//  BasketServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

enum BasketServerAPI{
    case getBasket
    case addDishInBasket(dish_id: Int, portion_id: Int, quantity: Int)
    case chageQuantity(item_id: Int, quantity: Int)
    case removeDishFromBasket(item_id: Int)
    case updateExtra(extra_id: Int, quantity: Int)
    case checkout(name: String, phone: String, order_time: String, delivery_type_id: DeliveryType, payment_type_id: PaymentType, delivery_address_id: Int?, title: String?, street: String?, house: String?, porch: String?, flat: String?, door_code: String?, floor: Int?, cafe_id: Int?, exchange: Int?)
    case confirmCheckout(cart_id: Int)
}

extension BasketServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .getBasket:
            return "/user/cart"
        case .addDishInBasket:
            return "/user/cart/store"
        case .chageQuantity(let item_id, _):
            return "/user/cart/\(item_id)/update"
        case .removeDishFromBasket(let item_id):
            return "/user/cart/\(item_id)/delete"
        case .updateExtra(let extra_id, _):
            return "/user/cart/extra/\(extra_id)/update"
        case .checkout:
            return "/user/cart/checkout"
        case .confirmCheckout(let cart_id):
            return "/user/cart/checkout/\(cart_id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBasket, .removeDishFromBasket, .confirmCheckout:
            return .get
        case .addDishInBasket, .chageQuantity, .updateExtra, .checkout:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getBasket, .removeDishFromBasket, .confirmCheckout:
            return .requestPlain
        case .addDishInBasket(let dish_id, let portion_id, let quantity):
            let params: [String: Int] = ["dish_id": dish_id,
                                         "portion_id": portion_id,
                                         "quantity": quantity]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .chageQuantity(_, let quantity):
            let params: [String: Int] = ["quantity": quantity]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .updateExtra(_, let quantity):
            let params: [String: Int] = ["quantity": quantity]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .checkout(let name, let phone, let order_time, let delivery_type_id, let payment_type_id, let delivery_address_id, let title, let street, let house, let porch, let flat, let door_code, let floor, let cafe_id, let exchange):
            var params: [String: Any] = ["name": name,
                                         "phone": phone,
                                         "order_time": order_time,
                                         "delivery_type_id": delivery_type_id.id,
                                         "payment_type_id": payment_type_id.id]
            if let delivery_address_id = delivery_address_id{
                params["delivery_address_id"] = delivery_address_id
            }else{
                if let title = title{
                    params["title"] = title
                }
                if let street = street{
                    params["street"] = street
                }
                if let house = house{
                    params["house"] = house
                }
                if let porch = porch{
                    params["porch"] = porch
                }
                if let flat = flat{
                    params["flat"] = flat
                }
                if let door_code = door_code{
                    params["door_code"] = door_code
                }
                if let floor = floor{
                    params["floor"] = floor
                }
            }
            
            if delivery_type_id == .pickup{
                params["cafe_id"] = cafe_id
            }
            
            if payment_type_id == .cash{
                params["exchange"] = exchange
            }
            
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .getBasket, .addDishInBasket, .chageQuantity, .removeDishFromBasket, .updateExtra, .confirmCheckout, .checkout:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
    
}
