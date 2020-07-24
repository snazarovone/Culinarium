//
//  AuthAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift
import ObjectMapper
import Alamofire


class AuthAPI{
    static func requstAuthAPI <T>(type: T.Type, request: AuthServerAPI, delegate:AppDelegate, callback: @escaping (T?)->()) where T : BaseResponseModel{
        delegate.providerAuthServerAPI.rx.request(request).mapObject(T.self).asObservable().subscribe(onNext: { (responce) in
            callback(responce)
        }, onError: { e in
            
            let error = e as! MoyaError
            let responce = T(success: false, error: error.localizedDescription)
            callback(responce)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: delegate.disposeBag)
    }
}
