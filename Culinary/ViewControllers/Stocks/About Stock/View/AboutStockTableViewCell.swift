//
//  AboutStockTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 22.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class AboutStockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleStock: UILabel!
    @IBOutlet weak var timeStock: UILabel! //54 минуты is default
    @IBOutlet weak var descriptionStock: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    
    var endTime: Date?
    
    weak var dataStock: StockCellViewModelType?{
        willSet(data){
            timeTitle.text = "до конца \((data?.titleVC ?? "").lowercased())"
            titleStock.text = data?.titleStock
            descriptionStock.text = data?.description
            endTime = data?.date_end
            timerTick()
        }
    }
    
    public func timerTick(){
        let currentDate = Date()
        if let endTime = endTime{
            let def = Int(endTime.timeIntervalSince1970 - currentDate.timeIntervalSince1970)
            if def > 0{
                let dFormat = timeFormatted(def)
                if dFormat.0 > 0{
                    timeStock.text = dFormat.0.days()
                    return
                }
                
                if dFormat.1 > 0{
                    timeStock.text = dFormat.1.hours()
                    return
                }
                
                if dFormat.2 > 0{
                    timeStock.text = dFormat.2.minutes()
                    return
                }
                
                timeStock.text = 1.minutes()
                return
            }
        }
        timeStock.text = "завершена"
        timeTitle.text = ""
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> (Int, Int, Int, Int) {
        let days: Int = totalSeconds / 86400
        let hours: Int = (totalSeconds % 86400) / 3600
        let minutes: Int = ((totalSeconds % 86400) % 3600) / 60
        let seconds: Int = ((totalSeconds % 86400) % 3600) % 60
        
        return (days, hours, minutes, seconds)
    }
}
