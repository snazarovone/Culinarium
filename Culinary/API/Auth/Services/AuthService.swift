//
//  AuthService.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import VK_ios_sdk

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate{
    
    private let appId = "7326089"
    private let vkSdk: VKSdk
    private var openIsMobelApp = true
    private var isConnectVK = false //для привязки соцсети из раздела профиля социальные сети
    
    weak var delegate: AuthServiceDelegate?
    weak var socialDelegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession(){
        let scope = ["email", "offline"]
        isConnectVK = false
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                VKSdk.authorize(scope)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    func vkGetUser(isAuthorize: Bool, callback: @escaping (String?, String?) -> ()){
        let scope = ["email", "offline"]
        isConnectVK = true
        VKSdk.wakeUpSession(scope) {[weak self] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                if VKSdk.isLoggedIn() {
                    let userId = VKSdk.accessToken().userId
                    if (userId != nil) {
                        
                        VKApi.users().get([VK_API_FIELDS:"first_name, last_name",
                                           VK_API_USER_ID: userId!]).execute(resultBlock: { (response) -> Void in
                                            
                                            let user = response!.json as! NSArray
                                            let userParams = user[0] as! NSDictionary
                                            let first_name = userParams["first_name"] as? String ?? ""
                                            let last_name = userParams["last_name"] as? String ?? ""
                                            
                                            callback("\(first_name) \(last_name)", userId)
                                           }, errorBlock: { (error) -> Void in
                                            print("Error2: \(String(describing: error))")
                                            callback(nil, nil)
                                           })
                    }
                }
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                if isAuthorize{
                    VKSdk.authorize(scope)
                }
                callback(nil, nil)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                callback(nil, nil)
                self?.socialDelegate?.authServiceDidSignInFail()
            }
        }
    }
    
    
    func logout(){
        VKSdk.forceLogout()
    }
    
    //MARK:- VkSdk Delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if isConnectVK == false{
            //авторизация
            if result.token != nil, let id = result.token.userId {
                if openIsMobelApp == true{
                    delegate?.authServiceSignIn(email: result.token.email, id: "\(id)")
                    delegate?.vkSdkDidDismiss()
                }else{
                    delegate?.authServiceSignIn(email: result.token.email, id: "\(id)")
                }
            }else{
                if openIsMobelApp{
                    delegate?.authServiceSignIn(email: nil, id: nil)
                    delegate?.vkSdkDidDismiss()
                }else{
                    delegate?.authServiceSignIn(email: nil, id: nil)
                }
            }
        }else{
            //привязка
            if result.token != nil, let id = result.token.userId {
                if openIsMobelApp == true{
                    socialDelegate?.authServiceSignIn(email: result.token.email, id: "\(id)")
                    socialDelegate?.vkSdkDidDismiss()
                }else{
                    socialDelegate?.authServiceSignIn(email: result.token.email, id: "\(id)")
                }
            }else{
                if openIsMobelApp{
                    socialDelegate?.authServiceSignIn(email: nil, id: nil)
                    socialDelegate?.vkSdkDidDismiss()
                }else{
                    socialDelegate?.authServiceSignIn(email: nil, id: nil)
                }
            }
        }
    }
    
    func vkSdkDidDismiss(_ controller: UIViewController!) {
        print(#function)
        openIsMobelApp = true
        if isConnectVK == false{
            //метод сработает если авторизация будет происходить через браузер
            delegate?.vkSdkDidDismiss()
        }else{
             //привязка
            socialDelegate?.vkSdkDidDismiss()
        }
    }

    
    //MARK:- VkSdk UI Delegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        //метод сработает если авторизация будет происходить через браузер
        openIsMobelApp = false
        if isConnectVK == false{
            delegate?.authServiceShouldShow(controller )
        }else{
            socialDelegate?.authServiceShouldShow(controller )
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    
}
