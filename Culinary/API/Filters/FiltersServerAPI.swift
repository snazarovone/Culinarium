//
//  FiltersServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum FiltersServerAPI{
    case quickFilters(section_id: Int, cash_payment: QuickFilters, express_delivery: QuickFilters, discount: QuickFilters)
    case filters(section_id: Int, id_filters: String)
}

extension FiltersServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .quickFilters(let section_id):
            return "/sections/\(section_id)/dishes/quick_filter"
        case .filters(let section_id, _):
            print("/sections/\(section_id)/dishes/filter")
            return "/sections/\(section_id)/dishes/filter"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .quickFilters, .filters:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .quickFilters(_, let cash_payment, let express_delivery, let discount):
            return .requestParameters(parameters: ["cash_payment" : cash_payment.value, "express_delivery": express_delivery.value,"discount": discount.value], encoding: URLEncoding.default)
        case .filters(_, let id_filters):
            return .requestParameters(parameters: ["filters" : id_filters], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .quickFilters, .filters:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
      
}
