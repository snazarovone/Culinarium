//
//  AddressCafeTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class AddressCafeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameCafe: UILabel!
    @IBOutlet weak var timeWork: UILabel!
    @IBOutlet weak var addressCafe: UILabel!
    @IBOutlet weak var metroName: UILabel!
    @IBOutlet weak var circleMetro: UIViewDesignable! //border Color metro station
    
    weak var cafeDelegate: AboutCafeDelegate?

    weak var dataAddress: AddressCafeCellModelType?{
        willSet(data){
            self.nameCafe.text = data?.nameCafe
            self.timeWork.text = data?.timeWork
            self.addressCafe.text = data?.addressCafe
            self.metroName.text = data?.metroName
            self.circleMetro.borderC = data?.colorCircle ?? .green
        }
    }
    
    @IBAction func call(_ sender: UIButton) {
        cafeDelegate?.call()
    }
    
    @IBAction func route(_ sender: UIButton) {
        cafeDelegate?.route()
    }
    
    @IBAction func feedback(_ sender: UIButton) {
        cafeDelegate?.feedback()
    }
}
