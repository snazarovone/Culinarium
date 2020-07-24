//
//  ListCafeCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 21.02.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class ListCafeCellViewModel: ListCafeCellViewModelType{
    var address: String?
    
    var nameCafe: String?
    
    var timeWork: String?
    
    var phoneNumber: String?
    
    var metroCIrcle: UIColor?
    
    var metroStateTitle: String?
    
    var distance: String?
    
    init(cafe: Cafe){
        self.address = cafe.address
        self.nameCafe = cafe.title
        self.phoneNumber = cafe.phone
        
        if let color = cafe.metro_station?.metro_line?.color{
            self.metroCIrcle = color.hexStringToUIColor
        }else{
            metroCIrcle = .green
        }
        
        metroStateTitle = cafe.metro_station?.metro_line?.title
        
        if let distance = cafe.distance{
            let km = Double(distance) / 1000.0
            if km > 1{
                let kmR = String(format: "%.1f", km)
                self.distance = "\(kmR) км"
            }else{
                self.distance = "\(distance) м"
            }
            
        }else{
            distance = nil
        }
      
        var timeW = ""
        let sTO = (cafe.open ?? "").split(separator: ":")
        timeW += "("
        if sTO.count >= 2{
            let sTO_hour = sTO[0]
            let sTO_Min = sTO[1]
            timeW += "\(sTO_hour):\(sTO_Min)"
            let sTC = (cafe.close ?? "").split(separator: ":")
            if sTO.count >= 2{
                let sTC_Hour = sTC[0]
                let sTC_Min = sTC[1]
                timeW += "-\(sTC_Hour):\(sTC_Min)"
            }
        }
        timeW += ")"
        if let working_days = cafe.working_days{
            timeW = "\(working_days) \(timeW)"
        }
        self.timeWork = timeW
    }
    
}
