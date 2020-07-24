//
//  BaseUrlModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum BaseUrlModel{
    case url
}

extension BaseUrlModel{
    var value: URL{
        switch self {
        case .url:
            return URL(string: "http://msofter.com/kulinarium/api")!
        }
    }
}
