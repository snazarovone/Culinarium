//
//  RestorePasswordViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 03.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class RestorePasswordViewModel{
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    public func requestRestoreAccount(email: String?, dataAuth: @escaping (AuthModel?)->()){
        guard let email = email else {
            dataAuth(nil)
            return
        }
        
        if email.isValidEmail() == false{
            dataAuth(nil)
            return
        }
        
        AuthAPI.requstAuthAPI(type: AuthModel.self,
                              request: .resetPassword(email: email),
                              delegate: delegate) { (authModel) in
                                dataAuth(authModel)
        }
    }
}
