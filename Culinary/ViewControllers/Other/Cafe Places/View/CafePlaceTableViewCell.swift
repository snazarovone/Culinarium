//
//  CafePlaceTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class CafePlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var nameCafe: UILabel!
    @IBOutlet weak var metroStation: UILabel!
    @IBOutlet weak var circleMetro: UIViewDesignable!
    
    
    weak var dataCafe: CafePlaceCellViewModelType?{
        willSet(data){
            self.street.text = data?.street
            self.nameCafe.text = data?.nameCafe
            self.metroStation.text = data?.nameMetroStatetion
            self.circleMetro.borderC = data?.circleColor ?? .green
        }
    }

}
