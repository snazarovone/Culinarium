//
//  WishlistServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum WishlistServerAPI {
    case addWishlist(dish_id: Int)
    case removeWishlist(dish_id: Int)
    case getWishlist
}

extension WishlistServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .addWishlist:
            return "/wishlists"
        case .removeWishlist(let dish_id):
            return "/wishlists/\(dish_id)"
        case .getWishlist:
            return "/wishlists"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addWishlist, .removeWishlist:
            return .post
        case .getWishlist:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .addWishlist(let dish_id):
            return .requestParameters(parameters: ["dish_id": dish_id], encoding: URLEncoding.default)
        case .removeWishlist, .getWishlist:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .addWishlist, .removeWishlist, .getWishlist:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
}
