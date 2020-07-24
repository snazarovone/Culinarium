//
//  OtherRedModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 26.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

enum OtherRedModel: OtherModelType {
    var typeCell: OthersCellType{
        return .red
    }
    
    case bankets
    case feedback
    case invate
    
}

extension OtherRedModel{
    var img: UIImage{
        switch self {
        case .bankets:
            return #imageLiteral(resourceName: "ic_banket")
        case .feedback:
            return #imageLiteral(resourceName: "ic_feedback2")
        case .invate:
            return #imageLiteral(resourceName: "ic_profileplus")
        }
    }
    
    var description: String{
        switch self {
        case .bankets:
            return "Организаниция вашего мероприятия"
        case .feedback:
            return "О доставке, о кафе, о блюде"
        case .invate:
            return "И получи 100 баллов на свой счет"
        }
    }
    
    var headerTitle: String{
        switch self {
        case .bankets:
            return "Банкеты и кейтеринг"
        case .feedback:
            return "Оставить отзыв"
        case .invate:
            return "Пригласить друга"
        }
    }
    
    var segueID: SegueID?{
        switch self {
        case .bankets:
            return SegueID.organize
        case .feedback:
            return SegueID.fillFeedback
        case .invate:
            return nil
        }
    }
}
