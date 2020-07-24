//
//  FeedbackServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum FeedbackServerAPI{
    case getFeedbackDish(dishId: Int)
   
    case sendFeedbackDelivery(name: String, surname: String, phone: String, text: String, strengths: String, weaknesses: String, rating: Int, images: [Data])
    case sendFeedbackDish(dish_id: Int, name: String, surname: String, phone: String, text: String, strengths: String, weaknesses: String, rating: Int, images: [Data])
    case sendFeedbackOther(name: String, surname: String, phone: String, text: String, strengths: String, weaknesses: String, rating: Int, images: [Data])
    
    case sendFeedbackCafe(cafe_id: Int, name: String, surname: String, phone: String, text: String, strengths: String, weaknesses: String, rating: Int, images: [Data])
    
    case callback(name: String, time: String, phone: String, text: String)
}

extension FeedbackServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .getFeedbackDish(let dishId):
            return "/dish/\(dishId)/reviews"
        case .sendFeedbackDelivery:
            return "/delivery/reviews"
        case .sendFeedbackDish(let dish_id, _, _, _, _, _, _, _, _):
            return "/dishes/\(dish_id)/review"
        case .sendFeedbackOther:
            return "/other/review"
        case .sendFeedbackCafe(let cafe_id, _, _, _, _, _, _, _, _):
            return "/cafes/\(cafe_id)/review"
        case .callback:
            return "/callback"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFeedbackDish:
            return .get
        case .sendFeedbackDelivery, .sendFeedbackDish, .sendFeedbackOther, .sendFeedbackCafe, .callback:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getFeedbackDish:
            return .requestPlain
        case .sendFeedbackDelivery(let name, let surname, let phone, let text, let strengths, let weaknesses, let rating, let images), .sendFeedbackOther(let name, let surname, let phone, let text, let strengths, let weaknesses, let rating, let images):
            
            var formData = [Moya.MultipartFormData]()
            
            formData = images.enumerated().map{MultipartFormData(provider:  .data($0.element), name: "images[\($0.offset)]", fileName: "photo.jpg", mimeType: "image/jpeg")}
            
            let params: [String: Any] = ["name": name, "surname": surname, "phone": phone, "text": text, "strengths": strengths, "weaknesses": weaknesses, "rating": rating]

            if formData.count == 0{
                let d = MultipartFormData(provider: .data(Data()), name: "images")
                formData.append(d)
            }
            return .uploadCompositeMultipart(formData, urlParameters: params)
       
        case .sendFeedbackDish(_, let name, let surname, let phone, let text, let strengths, let weaknesses, let rating, let images),
             .sendFeedbackCafe(_, let name, let surname, let phone, let text, let strengths, let weaknesses, let rating, let images):
          
            var formData = [Moya.MultipartFormData]()
            
            formData = images.enumerated().map{MultipartFormData(provider:  .data($0.element), name: "images[\($0.offset)]", fileName: "photo.jpg", mimeType: "image/jpeg")}
            
            let params: [String: Any] = ["name": name, "surname": surname, "phone": phone, "text": text, "strengths": strengths, "weaknesses": weaknesses, "rating": rating]

            if formData.count == 0{
                let d = MultipartFormData(provider: .data(Data()), name: "images")
                formData.append(d)
            }
            return .uploadCompositeMultipart(formData, urlParameters: params)
            
        case .callback(let name, let time, let phone, let text):
            
            let params: [String: Any] = ["name": name,
                                         "time": time,
                                         "phone": phone,
                                         "text": text]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .getFeedbackDish, .callback:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        case .sendFeedbackDelivery, .sendFeedbackDish, .sendFeedbackOther, .sendFeedbackCafe:
            params = ["Content-Type": "multipart/form-data",
            "Accept": "application/json",
            "Authorization": "Bearer \(UserAuth.shared.token ?? "")"]
        }
        return params
    }
    
}
