//
//  FilterCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 31.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FilterCellViewModel: FilterCellViewModelType{
    
    var name: String?{
        if let fItem = fItem{
            return fItem.value
        }else{
            if let value = cafeItem?.value{
                if let type_value = cafeItem?.value_type{
                    return "\(value) \(type_value)"
                }else{
                    return "\(value)"
                }
            }
            return nil
        }
    }
    
    var select: UIImage?{
        if let fItem = fItem{
            if fItem.isSelect{
                return #imageLiteral(resourceName: "Check")
            }else{
                return nil
            }
        }else{
            if cafeItem!.isSelect{
                return #imageLiteral(resourceName: "Check")
            }else{
                return nil
            }
        }
    }
    
    var borderColor: UIColor?{
        if let fItem = fItem{
            if fItem.isSelect{
                return .clear
            }else{
                return UIColor(named: "B8B1AB_30")
            }
        }else{
            if cafeItem!.isSelect{
                return .clear
            }else{
                return UIColor(named: "B8B1AB_30")
            }
        }
    }
    
    private var fItem: FiltersSectionValues?
    private var cafeItem: FilterCafeValue?
    
    init(fItem: FiltersSectionValues){
        self.fItem = fItem
    }
    
    init(filterCafeValue: FilterCafeValue){
        self.cafeItem = filterCafeValue
    }
    
}
