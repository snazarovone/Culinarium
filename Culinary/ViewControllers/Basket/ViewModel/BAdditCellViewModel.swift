//
//  BAdditCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class BAdditCellViewModel: BasketModelType, BAdditCellViewModelType{
    
    var idExtraGlass: Int?{
        for extra in extras{
            if let id = extra.extra?.id, id == ExtrasType.glass.id{
                return extra.id
            }
        }
        return nil
    }
    
    var idExtraCutlery: Int?{
        for extra in extras{
            if let id = extra.extra?.id, id == ExtrasType.cutlery.id{
                return extra.id
            }
        }
        return nil
    }
    
    
    var basketCellType: BasketCellType{
        return .additionally
    }
    
    var countCutlery: String{
        for extra in extras{
            if let id = extra.extra?.id, id == ExtrasType.cutlery.id{
                return "\(extra.quantity ?? 0)"
            }
        }
        return "\(0)"
    }
    
    var countGlass: String{
        for extra in extras{
            if let id = extra.extra?.id, id == ExtrasType.glass.id{
                return "\(extra.quantity ?? 0)"
            }
        }
        return "\(0)"
    }
    
    private let extras: [BasketExtraModel]
    
    init(extras: [BasketExtraModel]){
        self.extras = extras
    }
}

enum ExtrasType: CaseIterable{
    case glass
    case cutlery
}

extension ExtrasType{
    var id: Int{
        switch self {
        case .cutlery:
            return 2
        case .glass:
            return 1
        }
    }
}
