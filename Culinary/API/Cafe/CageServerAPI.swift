//
//  CageServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

enum CageServerAPI{
    case listCafe(lat: String, lng: String)
    case getFeedbackAboutCafe(cafe_id: Int)
    case filterCafe(lat: String, lng: String, type: String, delivery: String, radius: String)
}

extension CageServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .listCafe:
            return "/cafes"
        case .getFeedbackAboutCafe(let cafe_id):
            return "/cafes/\(cafe_id)/reviews"
        case .filterCafe:
            return "/cafes/filters"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listCafe, .filterCafe:
            return .post
        case .getFeedbackAboutCafe:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .listCafe(let lat, let lng):
            let params: [String: String] = ["lat": lat,
                                            "lng": lng]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .filterCafe(let lat, let lng, let type, let delivery, let radius):
            let params: [String: String] = ["lat": lat,
                                            "lng": lng,
                                            "type": type,
                                            "delivery": delivery,
                                            "radius": radius]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getFeedbackAboutCafe:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                            "Accept": "application/json"]
        switch self {
        case .listCafe, .getFeedbackAboutCafe, .filterCafe:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        }
        return params
    }
}
