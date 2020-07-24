//
//  AuthServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum AuthServerAPI{
    case auth(email: String, password: String, sns: SnsModel, provider_id: String?, provider_name: String?)
    case resetPassword(email: String)
    case logout
}

extension AuthServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/auth"
        case .resetPassword:
            return "/password/email"
        case .logout:
            return "/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .auth, .resetPassword, .logout:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .auth(let email, let password, let sns, let provider_id, let provider_name):
            var params: [String: Any] = ["email": email,
                                         "password": password,
                                         "sns": sns.value]
          
            if let provider_id = provider_id{
                params["provider_id"] = provider_id
            }
            
            if let provider_name = provider_name{
                params["provider_name"] = provider_name
            }
                      
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .resetPassword(let email):
            return .requestParameters(parameters: ["email" : email],
                                      encoding: URLEncoding.default)
        case .logout:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "Accept": "application/json"]
    }
    
}
