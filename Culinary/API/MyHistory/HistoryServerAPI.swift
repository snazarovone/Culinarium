//
//  HistoryServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

enum HistoryServerAPI{
    case archive
    case curentOrders
    case repeatOrder(order_id: Int)
    case detailOrder(order_id: Int)
}


extension HistoryServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .archive:
            return "/user/orders/archive"
        case .curentOrders:
            return "/user/orders/current"
        case .repeatOrder(let order_id):
            return "/user/orders/\(order_id)/replicate"
        case .detailOrder(let order_id):
            return "/user/orders/\(order_id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .archive, .curentOrders, .repeatOrder, .detailOrder:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .archive, .curentOrders, .repeatOrder, .detailOrder:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .archive, .curentOrders, .repeatOrder, .detailOrder:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
    
}
