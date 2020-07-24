//
//  OtherInfoModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum OtherInfoModel: OtherModelType {
    var typeCell: OthersCellType{
        return .info
    }
    
    case about
    case delivery
    case contacts
    case settings
    
}

extension OtherInfoModel{
    var img: UIImage{
        switch self {
        case .about:
            return #imageLiteral(resourceName: "ic_info_black")
        case .delivery:
            return #imageLiteral(resourceName: "ic_car_delivery")
        case .contacts:
            return #imageLiteral(resourceName: "ic_call_black2")
        case .settings:
            return #imageLiteral(resourceName: "ic_settings")
        }
    }
    
    var description: String{
        switch self {
        case .about:
            return "О компании"
        case .delivery:
            return "Условия доставки и оплаты"
        case .contacts:
            return "Контакты"
        case .settings:
            return "Настройки"
        }
    }
    
    var segue: SegueID?{
        switch self {
        case .delivery:
            return SegueID.deliveryInfo
        case .settings:
            return SegueID.settings
        case .contacts:
            return SegueID.contacts
        case .about:
            return SegueID.aboutCompany
        }
    }
}
