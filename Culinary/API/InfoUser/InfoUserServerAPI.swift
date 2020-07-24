//
//  InfoUserServerAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum InfoUserServerAPI {
    case addAddress(title: String, city: String, street: String, house: String?, porch: String?, flat: String?, door_code: String?, floor: Int?)
    case getAddressesDelivery
    case deleteAddress(id: Int)
    case getUserInfo
    case changeUserInfo(name: String?, surname: String?, patronymic: String?, birth_date: String?, gender: GenderModel, phone: String?)
    case getNewsletter
    case setNewsletter(status: NewsLetter)
    case newPassword(current_password: String, new_password: String, new_password_confirm: String)
    case sendMessage(chat_id: Int, text: String, images:  [Data])
    case userChats
    case statusIsRead(chat_id: Int)
    case userAccounts
    case connectSocialNetwork(provider_id: String, provider_name: String)
    case removeConnectSocialNetwork(provider_name: String)
}

extension InfoUserServerAPI: TargetType{
    var baseURL: URL {
        return BaseUrlModel.url.value
    }
    
    var path: String {
        switch self {
        case .addAddress, .getAddressesDelivery:
            return "/user/addresses"
        case .deleteAddress(let id):
            return "/user/addresses/\(id)/destroy"
        case .getUserInfo, .changeUserInfo:
            return "/user"
        case .getNewsletter, .setNewsletter:
            return "/user/newsletter"
        case .newPassword:
            return "/user/password/change"
        case .userChats:
            return "/user/chats"
        case .sendMessage:
            return "/user/chats/reply/send"
        case .statusIsRead(let chat_id):
            return "/user/chats/\(chat_id)/read"
        case .userAccounts, .connectSocialNetwork:
            return "/user/accounts"
        case .removeConnectSocialNetwork:
            return "/user/accounts/delete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addAddress, .changeUserInfo, .setNewsletter, .newPassword, .sendMessage, .connectSocialNetwork, .removeConnectSocialNetwork:
            return .post
        case .deleteAddress, .getAddressesDelivery, .getUserInfo, .getNewsletter, .userChats, .statusIsRead, .userAccounts:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .addAddress(let title, let city, let street, let house, let porch, let flat, let door_code, let floor):
            var params: [String: Any] = ["title": title,
                                         "city": city,
                                         "street": street]
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
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
            
        case .changeUserInfo(let name, let surname, let patronymic, let birth_date, let gender, let phone):
            var params: [String: Any] = ["gender": "\(gender.tag)"]
            if let name = name{
                params["name"] = name
            }
            if let surname = surname{
                params["surname"] = surname
            }
            if let patronymic = patronymic{
                params["patronymic"] = patronymic
            }
            if let birth_date = birth_date{
                params["birth_date"] = birth_date
            }
            if let phone = phone{
                params["phone"] = phone
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .setNewsletter(let status):
            let params: [String: Int] = ["status": status.value]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .newPassword(let current_password, let new_password, let new_password_confirm):
            let params: [String: String] = ["current_password": current_password,
                                            "new_password": new_password,
                                            "new_password_confirm": new_password_confirm]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        case .deleteAddress, .getUserInfo, .getAddressesDelivery, .getNewsletter, .userChats, .statusIsRead, .userAccounts:
            return .requestPlain
        
        case .sendMessage(let chat_id, let text, let images):
            var formData = [Moya.MultipartFormData]()
            
            formData = images.enumerated().map{MultipartFormData(provider:  .data($0.element), name: "images[\($0.offset)]", fileName: "photo.jpg", mimeType: "image/jpeg")}
            
            let params: [String: Any] = ["chat_id": chat_id, "text": text]

            if formData.count == 0{
                let d = MultipartFormData(provider: .data(Data()), name: "images")
                formData.append(d)
            }
            return .uploadCompositeMultipart(formData, urlParameters: params)
        case .connectSocialNetwork(let provider_id, let provider_name):
            let params: [String: String] = ["provider_id": provider_id,
                                            "provider_name": provider_name]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .removeConnectSocialNetwork(let provider_name):
            let params: [String: String] = ["provider_name": provider_name]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var params = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]
        switch self {
        case .addAddress, .getAddressesDelivery, .deleteAddress, .getUserInfo, .changeUserInfo, .getNewsletter, .setNewsletter, .newPassword, .userChats, .statusIsRead, .userAccounts, .connectSocialNetwork, .removeConnectSocialNetwork:
            params["Authorization"] = "Bearer \(UserAuth.shared.token ?? "")"
        case .sendMessage:
            params = ["Content-Type": "multipart/form-data",
                      "Accept": "application/json",
                      "Authorization": "Bearer \(UserAuth.shared.token ?? "")"]
        }
        return params
    }
}
