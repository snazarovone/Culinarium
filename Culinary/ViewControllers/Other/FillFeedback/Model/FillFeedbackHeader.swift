//
//  FillFeedbackHeader.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

enum FillFeedbackHeader: CaseIterable {
    case aboutDelivery
    case aboutCafe
    case aboutDish
    case aboutOther
}

extension FillFeedbackHeader{
    var title: String{
        switch self {
        case .aboutDelivery:
            return "о доставке"
        case .aboutCafe:
            return "о кафе"
        case .aboutDish:
            return "о блюде"
        case .aboutOther:
            return "о другом"
        }
    }
    
    var indexRow: Int{
        switch self {
        case .aboutDelivery:
            return 0
        case .aboutCafe:
            return 1
        case .aboutDish:
            return 2
        case .aboutOther:
            return 3
        }
    }
    
    var titleNameVC: String?{
        switch self {
        case .aboutCafe:
            return "Кафе"
        case .aboutDish:
            return "Блюдо"
        default:
            return nil
        }
    }
}
