//
//  ListCafeTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 10.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class ListCafeTableViewCell: UITableViewCell {

    @IBOutlet weak var address: UILabelDesignable!
    @IBOutlet weak var nameCafe: UILabelDesignable!
    @IBOutlet weak var timeWork: UILabelDesignable!
    @IBOutlet weak var phoneNumber: UILabelDesignable!
    @IBOutlet weak var metroCIrcle: UIViewDesignable!
    @IBOutlet weak var metroStateTitle: UILabelDesignable!
    @IBOutlet weak var distance: UIButtonDesignable!
    
    
    weak var dataCafe: ListCafeCellViewModelType?{
        willSet(data){
            address.text = data?.address
            nameCafe.text = data?.nameCafe
            timeWork.text = data?.timeWork
            phoneNumber.text = data?.phoneNumber
            metroCIrcle.borderC = data?.metroCIrcle ?? .green
            metroStateTitle.text = data?.metroStateTitle
            distance.setTitle(data?.distance, for: .normal)
        }
    }
    
}
