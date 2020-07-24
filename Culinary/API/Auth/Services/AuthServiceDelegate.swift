//
//  AuthServiceDelegate.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn(email: String?, id: String?)
    func authServiceDidSignInFail()
    
    //метод в котором будет обрабатываться результат авторизации
    //должен вызываться в обоих случиях (авторизация через браузер или оф приложение)
    func vkSdkDidDismiss()
}
