//
//  LoginAppViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class LoginAppViewModel{
    
    let warningRestore: String = "Письмо для востановления \n пароля отправленно на почту"
    let warningPassword: String = "Неверный пароль"
    let warningEmailOrPassValidation = "Email или пароль не валидны"
    let warningNotExistEmail = "Требуется наличие email в соцсети"
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    public func requestIsExistUser(email: String?,
                                   password: String?,
                                   sns: SnsModel,
                                   provider_id: String?, provider_name: String?,
                                   callback: @escaping (AuthModel?)->()){
        guard let email = email, let password = password else {
            callback(nil)
            return
        }
        
        if email.isValidEmail() == false{
            callback(nil)
            return
        }
        
        requestAuth(email: email, password: password, sns: sns, provider_id: provider_id, provider_name: provider_name) { (authModel) in
            callback(authModel)
        }
        
    }
    
    private func requestAuth(email: String, password: String, sns: SnsModel, provider_id: String?, provider_name: String?,
                             callback: @escaping (AuthModel?)->()){
        AuthAPI.requstAuthAPI(type: AuthModel.self,
                              request: .auth(email: email, password: password, sns: sns, provider_id: provider_id, provider_name: provider_name),
                              delegate: delegate) { (authModel) in
                                callback(authModel)
        }
    }
    
    func generatedPass(at email: String) -> String{
        return email.md5
    }
    
    public func saveDataAuth(with token: String?, login: String?, pass: String?, idUser: String?, socialName: String?){
        UserAuth.shared = UserAuth(login: login, pass: pass, token: token, socialName: socialName, socialId: idUser)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: UserAuth.shared)
        UserDefaults.standard.set(encodedData, forKey: UDID.dataLogin.key)
    }
    
    public func removeDataAuth(){
        UserAuth.shared = UserAuth()
        UserDefaults.standard.removeObject(forKey: UDID.dataLogin.key)
    }
}
