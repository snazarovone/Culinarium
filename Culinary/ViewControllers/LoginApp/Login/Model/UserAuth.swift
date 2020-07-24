//
//  UserAuth.swift
//  Culinary
//
//  Created by Sergey Nazarov on 01.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class UserAuth: NSObject, NSCoding{
    
    static var shared = UserAuth()
    
    var login: String?
    var password: String?
    var token: String?
    var socialName: String?
    var socialId: String?
    
    override init(){
    }
    
    init(login: String?, pass: String?, token: String?, socialName: String?, socialId: String?){
        self.login = login
        self.password = pass
        self.token = token
        self.socialName = socialName
        self.socialId = socialId
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
        coder.encode(token, forKey: "token")
        coder.encode(socialName, forKey: "socialName")
        coder.encode(socialId, forKey: "socialId")
        
    }
    
    required init?(coder: NSCoder) {
        login = coder.decodeObject(forKey: "login") as? String
        password = coder.decodeObject(forKey: "password") as? String
        token = coder.decodeObject(forKey: "token") as? String
        socialName = coder.decodeObject(forKey: "socialName") as? String
        socialId = coder.decodeObject(forKey: "socialId") as? String
    }
    
    
}
