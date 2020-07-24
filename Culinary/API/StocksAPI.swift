//
//  StocksAPI.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.04.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Moya_ObjectMapper
import RxSwift
import ObjectMapper
import Alamofire


class StocksAPI{
    static func requestStocks <T>(type: T.Type, request: StocksServerAPI, delegate:AppDelegate, callback: @escaping (T?, Bool)->()) where T : BaseResponseModel{
           
           delegate.providerStocksServerAPI.manager.session.getAllTasks { (value) in
               
               for task in value{
                   if let currentRequest = task.currentRequest,
                       let url = currentRequest.url, url == URL(string: "\(request.baseURL.absoluteString)\(request.path)"){
                       task.cancel()
                   }
               }
               
           delegate.providerStocksServerAPI.rx.request(request).mapObject(T.self).asObservable().subscribe(onNext: { (responce) in
                   callback(responce, false)
               }, onError: { e in
                   let error = e as! MoyaError
                   let nsErrorCode = e as NSError
                   
                   if nsErrorCode.code != 6{
                       let responce = T(success: false, error: error.localizedDescription)
                       callback(responce, false)
                   }else{
                       callback(nil, true)
                   }
                   
               }, onCompleted: nil, onDisposed: nil).disposed(by: delegate.disposeBag)
           }
       }
}
