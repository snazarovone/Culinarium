//
//  FiltersAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 05.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift
import ObjectMapper
import Alamofire

class FiltersAPI{
    static func requstObjectFilters <T>(type: T.Type, request: FiltersServerAPI, delegate:AppDelegate, callback: @escaping (T?)->()) where T : BaseResponseModel{
        delegate.providerFiltersServerAPI.rx.request(request).mapObject(T.self).asObservable().subscribe(onNext: { (responce) in
            callback(responce)
        }, onError: { e in
            let error = e as! MoyaError
            let responce = T(success: false, error: error.localizedDescription)
            callback(responce)
            
        }, onCompleted: nil, onDisposed: nil).disposed(by: delegate.disposeBag)
    }
}
