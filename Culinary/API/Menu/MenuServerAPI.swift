//
//  MenuServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum MenuServerAPI{
    case getListSections
    case getSelectSectionMenu(section_id: Int)
    case searchDish(title: String)
    case getAllDish
}

extension MenuServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .getListSections:
            return "/sections"
        case .getSelectSectionMenu(let section_id):
            return "/sections/\(section_id)"
        case .searchDish:
            return "/dish/search"
        case .getAllDish:
            return "/dish"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getListSections, .getSelectSectionMenu, .getAllDish:
            return .get
        case .searchDish:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getListSections, .getSelectSectionMenu, .getAllDish:
            return .requestPlain
        case .searchDish(let title):
            return .requestParameters(parameters: ["title" : title], encoding: URLEncoding.default)
            
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .getListSections, .getSelectSectionMenu, .searchDish, .getAllDish:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
    
}
