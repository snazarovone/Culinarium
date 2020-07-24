//
//  ContactsServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

enum ContactsServerAPI {
    case contacts
}

extension ContactsServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .contacts:
            return "/contacts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .contacts:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .contacts:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .contacts:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
    
}

