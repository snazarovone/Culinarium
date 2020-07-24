//
//  InfoUserAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 15.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift
import ObjectMapper
import Alamofire

class InfoUserAPI{
    static func requstObjectInfoUser <T>(type: T.Type, request: InfoUserServerAPI, delegate:AppDelegate, callback: @escaping (T?)->()) where T : BaseResponseModel{
        delegate.providerInfoUserServerAPI.rx.request(request).mapObject(T.self).asObservable().subscribe(onNext: { (responce) in
            callback(responce)
        }, onError: { e in
            let error = e as! MoyaError
            let responce = T(success: false, error: error.localizedDescription)
            callback(responce)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: delegate.disposeBag)
    }
}
