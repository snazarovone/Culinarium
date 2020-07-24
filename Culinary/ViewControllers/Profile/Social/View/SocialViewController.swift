//
//  SocialViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController {
    
    @IBOutlet var logoSocials: [UIImageView]!
    @IBOutlet var name: [UILabel]!
    @IBOutlet var balls: [UILabel]!
    @IBOutlet var switches: [UISwitch]!
    
    //PRIVATE
    private var authService: AuthService!
    private var vkUserData: VKModel?
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    
    //PUBLIC
    public var socialData: UserAccountsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authService = (UIApplication.shared.delegate as! AppDelegate).authService
        authService.socialDelegate = self
        
        if let _ = socialData?.vk{
            authService.vkGetUser(isAuthorize: false) { [weak self] (value, _)  in
                if let value = value{
                    self?.connectSocial(social: .vk, text: value)
                    self?.switches[Socials.vk.tag].isOn = true
                }else{
                    self?.disconectSocial(social: .vk)
                    self?.switches[Socials.vk.tag].isOn = false
                }
            }

        }else{
            disconectSocial(social: .vk)
            switches[Socials.vk.tag].isOn = false
        }
        
        if socialData?.facebook != nil{
            connectSocial(social: .fb, text: "")
            switches[Socials.fb.tag].isOn = true
        }else{
            disconectSocial(social: .fb)
            switches[Socials.fb.tag].isOn = false
        }
        
    }
    
    //MARK:-  //запрос на привязку соцсети
    private func requestConnectSocNet(social: Socials, id: String){
        InfoUserAPI.requstObjectInfoUser(type: UserAccountsModel.self, request: .connectSocialNetwork(provider_id: id, provider_name: social.title), delegate: delegate) { _ in
        }
    }
    
    //MARK:-  //запрос удаление контакта соцсети
    private func requestRemoveConnectSocNet(social: Socials){
        InfoUserAPI.requstObjectInfoUser(type: UserAccountsModel.self, request: .removeConnectSocialNetwork(provider_name: social.title), delegate: delegate) { _ in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    fileprivate func connectSocial(social: Socials, text: String){
        logoSocials[social.tag].image = social.selectIcon
      
        name[social.tag].text = text
        name[social.tag].isHidden = false
        balls[social.tag].isHidden = true
    }
    
    fileprivate func disconectSocial(social: Socials){
        logoSocials[social.tag].image = social.unseslect
      
        name[social.tag].text = ""
        name[social.tag].isHidden = true
        balls[social.tag].isHidden = false
    }
    
    fileprivate func getSocial(at tag: Int) -> Socials{
        for s in Socials.allCases{
            if s.tag == tag{
                return s
            }
        }
        return .fb
    }
    
    @IBAction func sw(_ sender: UISwitch) {
        let social = getSocial(at: sender.tag)
        if sender.isOn{
            if social == .vk{
                authService.vkGetUser(isAuthorize: true) { [weak self] (value, id) in
                    if let value = value, let id = id{
                        self?.connectSocial(social: .vk, text: value)
                        self?.switches[Socials.vk.tag].isOn = true
                        self?.requestConnectSocNet(social:social, id: id)
                    }
                }
            }
        }else{
            if social == .vk{
                authService.logout()
            }
            disconectSocial(social: social)
            requestRemoveConnectSocNet(social: .vk)
        }
    }
    
    //MARK:- deinit
    deinit{
        print("SocialViewController is deinit")
    }
    
}

extension SocialViewController: AuthServiceDelegate{
    func authServiceShouldShow(_ viewController: UIViewController) {
        self.present(viewController, animated: true, completion: nil)
        print(#function)
    }
    
    func authServiceSignIn(email: String?, id: String?) {
        //отправка запроса (provider_id) на сохранение соцсети
        if let id = id{
            self.vkUserData = VKModel(email: nil, id: id)
        }else{
            self.vkUserData = nil
        }
    }
    
    func authServiceDidSignInFail() {
        self.disconectSocial(social: .vk)
        self.switches[Socials.vk.tag].isOn = false
    }
    
    func vkSdkDidDismiss() {
        if let vkModel = self.vkUserData{
            //запрос на привязку контакта
            
            self.requestConnectSocNet(social: .vk, id: vkModel.idUser)
            
            authService.vkGetUser(isAuthorize: false) { [weak self] (value, _)  in
                if let value = value{
                    self?.connectSocial(social: .vk, text: value)
                    self?.switches[Socials.vk.tag].isOn = true
                }else{
                    self?.disconectSocial(social: .vk)
                    self?.switches[Socials.vk.tag].isOn = false
                }
            }
        }else{
            self.authService.logout()
            self.disconectSocial(social: .vk)
            self.switches[Socials.vk.tag].isOn = false
        }
    }
    
}
