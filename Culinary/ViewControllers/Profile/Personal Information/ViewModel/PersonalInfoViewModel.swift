//
//  PersonalInfoViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class PersonalInfoViewModel{
    
    var userInfoData: BehaviorRelay<UserInfo?>
    var gender: GenderModel = .man
    
    private var delegate = UIApplication.shared.delegate as! AppDelegate
    private var auth: ErrorAuth? = nil
    
    init(userInfoData: BehaviorRelay<UserInfo?>){
        if userInfoData.value == nil{
            self.userInfoData = BehaviorRelay(value: UserInfo())
        }else{
            self.userInfoData = userInfoData
            self.gender = userInfoData.value?.gender ?? .man
        }
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
    
    public func formattedData(number: String) -> String{
        let clean = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XX.XX.XXXX"
        var result = ""
        var index = clean.startIndex
        for ch in mask where index < clean.endIndex {
            if ch == "X" {
                result.append(clean[index])
                index = clean.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func getGender() -> GenderModel{
        return userInfoData.value?.gender ?? .man
    }
    
    //MARK:- Favorite Dish
    func requestChangeUserInfo(name: String?, surname: String?, patronymic: String?, birth_date: String?, phone: String?, callback: @escaping (RequestComplite)->()){
        InfoUserAPI.requstObjectInfoUser(type: UserInfoModel.self, request: .changeUserInfo(name: name, surname: surname, patronymic: patronymic, birth_date: birth_date, gender: self.gender, phone: phone), delegate: self.delegate) { [weak self] (value) in
            if let userInfo = value{
                if let success = userInfo.success, success{
                    self?.userInfoData.accept(userInfo.data)
                    callback(.complite)
                }else{
                    if let error = userInfo.error, error == ErrorAuth.Unauthorized.value{
                        self?.auth = .Unauthorized
                    }
                    callback(.error)
                }
            }
            else{
                callback(.error)
            }
        }
    }
    
    
    func getAuth() -> ErrorAuth? {
        return self.auth
    }
}
