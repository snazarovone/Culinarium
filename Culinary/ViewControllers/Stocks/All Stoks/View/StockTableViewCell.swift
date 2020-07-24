//
//  StockTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class StockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureStock: UIImageViewDesignable!
    @IBOutlet weak var titleStock: UILabel!
    @IBOutlet weak var timeStock: UILabel! //54 минуты is default
    @IBOutlet weak var descriptionStock: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    
    var endTime: Date?
    
    weak var dataStock: StockCellViewModelType?{
        willSet(data){
            timeTitle.text = "до конца \((data?.titleVC ?? "").lowercased())"
            getImage(by: URL(string: data?.image ?? ""))
            titleStock.text = data?.titleStock
            descriptionStock.text = data?.description
            endTime = data?.date_end
            timerTick()
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        pictureStock.sd_setImage(with: url, completed: nil)
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
