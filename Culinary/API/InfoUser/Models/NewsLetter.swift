//
//  NewsLetter.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum NewsLetter{
    case subscribe
    case notSubscribe
}

extension NewsLetter{
    var value: Int{
        switch self {
        case .notSubscribe:
            return 0
        case .subscribe:
            return 1
        }
    }
}
