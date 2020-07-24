//
//  FreezViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import Foundation

class FreezViewModel{
    
    var daysModel = [DaysModel]()
    var selectDays = IndexPath(row: 0, section: 0)
    
    init(){
        daysModel = [DaysModel(title: "1 день"),
                     DaysModel(title: "2 дня"),
                     DaysModel(title: "3 дня"),
                     DaysModel(title: "4 дня"),
                     DaysModel(title: "5 дней"),
                     DaysModel(title: "6 дней"),
                     DaysModel(title: "7 дней"),
                     DaysModel(title: "8 дней"),
                     DaysModel(title: "11 дней"),
                     DaysModel(title: "12 дней"),
                     DaysModel(title: "13 дней"),
                     DaysModel(title: "14 дней")]
    }
}
