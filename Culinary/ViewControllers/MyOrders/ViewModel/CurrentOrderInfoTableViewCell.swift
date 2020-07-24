//
//  CurrentOrderInfoTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class CurrentOrderInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var deliveryDate: UILabel!
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var day: UILabel! //00
    @IBOutlet weak var hour: UILabel! //00
    @IBOutlet weak var minutes: UILabel! //12
    @IBOutlet weak var seconds: UILabel!
    
    private var totalTime: Int64 = 0
    private weak var countdownTimer: Timer?
    private var dateDeliv: String = ""
 
    private var idOrder: Int?
    
    weak var infoOrderDelegate: InfoOrderDelegate?
    
    weak var dataCell: CurrentOrderCellViewModelType?{
        willSet(data){
            self.totalTime = data?.totalTime ?? 0
            self.numberOrder.text = data?.numberOrder
            self.position.text = data?.position
            self.createDate.text = data?.createDate
            self.payment.text = data?.payment
            self.price.text = data?.price
            self.dateDeliv = data?.deliveryDate ?? ""
            self.idOrder = data?.id
        
            updateData()
            if let countdownTimer = countdownTimer, countdownTimer.isValid == false{
                startTimer()
            }else{
                if countdownTimer == nil{
                    startTimer()
                }
            }
        }
    }
    
    private func updateData(){
        let timeF = timeFormatted(totalTime)
        day.text = timeF.0
        hour.text = timeF.1
        minutes.text = timeF.2
        seconds.text = timeF.3
        
        if totalTime == 0{
            self.deliveryDate.text = dateDeliv
        }else{
            self.deliveryDate.text = "Планируется \(dateDeliv)"
        }
    }
    
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        updateData()
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    private func endTimer() {
        if let countdownTimer = countdownTimer{
            countdownTimer.invalidate()
        }
    }
    
    private func timeFormatted(_ totalSeconds: Int64) -> (String, String, String, String) {
        let days: Int64 = totalSeconds / 86400
        let hours: Int64 = (totalSeconds % 86400) / 3600
        let minutes: Int64 = ((totalSeconds % 86400) % 3600) / 60
        let seconds: Int64 = ((totalSeconds % 86400) % 3600) % 60
        
        return (String(format: "%02d", days), String(format: "%02d", hours), String(format: "%02d", minutes), String(format: "%02d", seconds))
    }

    
    //MARK:- Actions
    @IBAction func about(_ sender: UIButton) {
        infoOrderDelegate?.aboutOrder(at: idOrder)
    }
    
    @IBAction func cancelOrder(_ sender: UIButton) {
        infoOrderDelegate?.cancelOrder()
    }
}
