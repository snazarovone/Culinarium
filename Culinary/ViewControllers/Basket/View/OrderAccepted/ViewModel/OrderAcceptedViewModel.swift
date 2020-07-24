//
//  OrderAcceptedViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 20.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OrderAcceptedViewModel: OrderAcceptedViewModelType{
    
    public var confirmBasket: BehaviorRelay<BasketConfirm?>
    
    init(confirmBasket: BehaviorRelay<BasketConfirm?>){
        self.confirmBasket = confirmBasket
    }
    
    var numberOrder: String{
        if let num = confirmBasket.value?.id{
            return "Заказ № \(num)"
        }else{
            return "Заказ"
        }
    }
    
    var deliveryMethod: String{
        if let title = confirmBasket.value?.delivery?.title{
            return title
        }else{
            return ""
        }
    }
    
    var address: String{
        var otherDataAddress = ""
        if let house = confirmBasket.value?.address?.house{
            otherDataAddress += " д.\(house),"
        }
        if let porch = confirmBasket.value?.address?.porch{
            otherDataAddress += " п.\(porch),"
        }
        if let flat = confirmBasket.value?.address?.flat{
            otherDataAddress += " кв.\(flat),"
        }
        if let floor = confirmBasket.value?.address?.floor{
            otherDataAddress += " э.\(floor),"
        }
        if let doorCode = confirmBasket.value?.address?.door_code{
            otherDataAddress += " код \(doorCode)"
        }
        
        if otherDataAddress.count > 0 && (otherDataAddress[otherDataAddress.index(before: otherDataAddress.endIndex)] == ","){
            otherDataAddress.removeLast()
        }
        
        if otherDataAddress == ""{
            return "г. \(confirmBasket.value?.address?.city ?? ""), \(confirmBasket.value?.address?.street ?? "")"
        }else{
            return "г. \(confirmBasket.value?.address?.city ?? ""), \(confirmBasket.value?.address?.street ?? ""),\(otherDataAddress)"
        }
    }
    
    var time: String{
        var timeString = ""
        if let date = confirmBasket.value?.date{
            if let time = confirmBasket.value?.time{
                timeString = "\(date) г.\n\(time)"
            }else{
                timeString = "\(date)"
            }
        }else{
            if let time = confirmBasket.value?.time{
                timeString = "\(time)"
            }
        }
        return timeString
    }
    
    var sum: String{
        if let sum = confirmBasket.value?.total_sum{
            return "\(sum)"
        }
        return ""
    }
    
}
