//
//  DefaultAlamofireManager.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class DefaultAlamofireManager : Alamofire.SessionManager{
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = nil
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

class DownloadAlamofireManager : Alamofire.SessionManager{
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = nil
        configuration.timeoutIntervalForRequest = 40
        configuration.timeoutIntervalForResource = 40
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
