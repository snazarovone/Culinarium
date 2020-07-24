//
//  StateShowCoupons.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum StateShowCoupons {
    case qr
    case description
}

extension StateShowCoupons{
    var titleBtn: String{
        switch self {
        case .qr:
            return "Подробности"
        case .description:
            return "Смотреть QR-код"
        }
    }
    
    var picture: (UIImage, UIView.ContentMode){
        switch self {
        case .qr:
            return (#imageLiteral(resourceName: "qr_big"), .center)
        case .description:
            return (#imageLiteral(resourceName: "IMG_2298"), .scaleAspectFill)
        }
    }
    
    var isDescription: Bool{
        switch self {
        case .qr:
            return true
        case .description:
            return false
        }
    }
}
