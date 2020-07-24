//
//  CafeCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import Foundation

class CafeCellViewModel: CafeCellViewModelType{
  
    var imgUrl: String?
    
    var titleCafe: String?
    
    var addressCafe: String?
    
    var distanceCafe: String?
    
    var openedTime: String?
    
    var nearest: Bool?
    
    init(cafe: Cafe){
        self.imgUrl = cafe.image
        self.titleCafe = cafe.title
        self.addressCafe = cafe.address
        
        if let distance = cafe.distance{
            let km = Double(distance) / 1000.0
            if km > 1{
                let kmR = String(format: "%.1f", km)
                distanceCafe = "\(kmR) км"
            }else{
                distanceCafe = "\(distance) м"
            }
            
            if distance <= 2000{
                nearest = false //ishiden
            }else{
                nearest = true //isHiden
            }
            
        }else{
            nearest = false
        }
        
        
        if let timeOpen = cafe.open, let tClose = cafe.close{
            isOpenCafe(timeOpen: timeOpen, timeClosed: tClose)
        }
        else{
            openedTime = nil
        }
        
    }
    
    
    func isOpenCafe(timeOpen: String, timeClosed: String){
        let date = Date()
        let dateCurrent = date.timeIntervalSince1970
        
        let sTO = timeOpen.split(separator: ":")
        if sTO.count == 3{
            let sTO_hour = Int(sTO[0])
            let sTO_Min = Int(sTO[1])
            let sTO_Sec = Int(sTO[2])
            
            let dateOpen = Calendar.current.date(bySettingHour: sTO_hour ?? 0, minute: sTO_Min ?? 0, second: sTO_Sec ?? 0, of: Date())
            
            if let dateOpen = dateOpen{
                let uTimeOpen = dateOpen.timeIntervalSince1970
                
                let sTC = timeClosed.split(separator: ":")
                if sTO.count == 3{
                    let sTC_Hour = Int(sTC[0])
                    let sTC_Min = Int(sTC[1])
                    let sTC_Sec = Int(sTC[2])
                    
                    let dateClose = Calendar.current.date(bySettingHour: sTC_Hour ?? 0, minute: sTC_Min ?? 0, second: sTC_Sec ?? 0, of: Date())
                    
                    if let dateClose = dateClose{
                        let uTimeClose = dateClose.timeIntervalSince1970
                        
                        if dateCurrent >= uTimeOpen && dateCurrent <= uTimeClose{
                            self.openedTime = "Открыто до \(sTO[0]):\(sTO[1])"
                        }else{
                            self.openedTime = "Закрыто до \(sTC[0]):\(sTC[1])"
                        }
                        return
                    }
                }
            }
        }
        self.openedTime = timeClosed
    }
}
