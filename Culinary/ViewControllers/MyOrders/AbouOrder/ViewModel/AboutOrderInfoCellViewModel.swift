//
//  AboutOrderInfoCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 23.03.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class AboutOrderInfoCellViewModel: AboutOrderType, AboutOrderInfoCellViewModelType{
    var nameUser: String?{
        if let name = detailInfo.user?.name{
            if let surname = detailInfo.user?.surname{
                return "\(name) \(surname)"
            }
            return "\(name)"
        }else{
            if let surname = detailInfo.user?.surname{
                return "\(surname)"
            }else{
                return nil
            }
        }
    }
    
    var phoneNumber: String?{
        if let phone = detailInfo.user?.phone{
            return "Телефон: \(phone)"
        }
        return nil
    }
    
    var deliveryType: String?{
        return detailInfo.delivery_type?.title
    }
    
    var timeOutDelivery: String?{
        if let dTime = detailInfo.order_time{
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let d = dateFormatter.date(from: dTime){
                let currentDate = Date()
                let seconds = d.timeIntervalSince1970 - currentDate.timeIntervalSince1970
                if seconds > 0{
                    return "Планируется \(dTime)"
                }else{
                    return "\(dTime)"
                }
            }
            return "\(dTime)"
        }
        return nil
    }
    
    var addressDelivery: String?{
        var otherDataAddress = ""
        if let house = detailInfo.address?.house{
            otherDataAddress += " д.\(house),"
        }
        if let porch = detailInfo.address?.porch{
            otherDataAddress += " п.\(porch),"
        }
        if let flat = detailInfo.address?.flat{
            otherDataAddress += " кв.\(flat),"
        }
        if let floor = detailInfo.address?.floor{
            otherDataAddress += " э.\(floor),"
        }
        if let doorCode = detailInfo.address?.door_code{
            otherDataAddress += " код \(doorCode)"
        }
        
        if otherDataAddress.count > 0 && (otherDataAddress[otherDataAddress.index(before: otherDataAddress.endIndex)] == ","){
            otherDataAddress.removeLast()
        }
        
        if otherDataAddress == ""{
            return "г. \(detailInfo.address?.city ?? ""), \(detailInfo.address?.street ?? "")"
        }else{
            return "г. \(detailInfo.address?.city ?? ""), \(detailInfo.address?.street ?? ""),\(otherDataAddress)"
        }
    }
    
    var paymet: String?{
        return detailInfo.payment_type?.title
    }
    
    var commentUser: String?{
        return detailInfo.comment
    }
    
    var weight: String?{
        if let weight = detailInfo.weight{
            return "\(weight) гр."
        }
        return nil
    }
    
    var countPortion: String?{
        if let portions = detailInfo.portions{
            return portions.portions()
        }
        return nil
    }
    
    var sum: String?{
        if let value = detailInfo.sum{
            return "\(value) ₽"
        }
        return nil
    }
    
    var discont: String?{
        if let value = detailInfo.discount{
            return "\(value) ₽"
        }
        return nil
    }
    
    var deliveryPrice: String?{
        if let value = detailInfo.delivery{
            return "\(value) ₽"
        }
        return nil
    }
    
    var totalSum: String?{
        if let value = detailInfo.total_sum{
            return "\(value) ₽"
        }
        return nil
    }
    
    var type: AboutOrderCellType{
        return .infoOrder
    }
    
    private let detailInfo: HistoryDetail
    init(detailInfo: HistoryDetail){
        self.detailInfo = detailInfo
    }
}
