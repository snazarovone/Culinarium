//
//  BackCallViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class BackCallViewModel: BackCallViewModelType{
    
    private let userInfo: BehaviorRelay<UserInfo?>
    private var auth: ErrorAuth? = nil
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    init(userInfo: BehaviorRelay<UserInfo?>){
        self.userInfo = userInfo
    }
    
    func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "+X(XXX) XXX-XX-XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }

    
    var phoneUser: String? {
        guard let phone =  userInfo.value?.phone, phone.count > 0 else {
            return nil
        }
        return formattedNumber(number: phone)
    }
    
    var name: String?{
        return userInfo.value?.name
    }
    
    
    //MARK:- Menu Section
    func requestListMeneSection(name: String, time: String, phone: String, text: String, callback: @escaping (RequestComplite)->()){
        
        FeedbackAPI.requstObjectFeedback(type: BaseResponseModel.self, request: .callback(name: name, time: time, phone: phone, text: text), delegate: delegate) { [weak self] (value) in
            if let value = value{
                if let success = value.success, success{
                    callback(.complite)
                }else{
                    if let error = value.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }else{
                callback(.error)
            }
        }
    }
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
