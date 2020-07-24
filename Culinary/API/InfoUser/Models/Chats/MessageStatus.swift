//
//  MessageStatus.swift
//  Culinary
//
//  Created by Sergey Nazarov on 29.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum MessageStatus {
    case read
    case unread
}

extension MessageStatus{
    var value: Int{
        switch self {
        case .read:
            return 1
        case .unread:
            return 0
        }
    }
}
