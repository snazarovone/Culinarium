//
//  AboutOrderInfoTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class AboutOrderInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var phoneNumber: UILabel! //Телефон:
    @IBOutlet weak var deliveryType: UILabel!
    @IBOutlet weak var timeOutDelivery: UILabel!
    @IBOutlet weak var addressDelivery: UILabel!
    @IBOutlet weak var paymet: UILabel!
    @IBOutlet weak var commentUser: UILabel!
    @IBOutlet weak var weight: UILabel! //гр.
    @IBOutlet weak var countPortion: UILabel!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var discont: UILabel!
    @IBOutlet weak var deliveryPrice: UILabel!
    @IBOutlet weak var totalSum: UILabel!
    
    
    weak var dataOrder: AboutOrderInfoCellViewModelType?{
        willSet(data){
            self.nameUser.text = data?.nameUser
            self.phoneNumber.text = data?.phoneNumber
            self.deliveryType.text = data?.deliveryType
            self.timeOutDelivery.text = data?.timeOutDelivery
            self.addressDelivery.text = data?.addressDelivery
            self.paymet.text = data?.paymet
            self.commentUser.text = data?.commentUser
            self.weight.text = data?.weight ?? " "
            self.countPortion.text = data?.countPortion ?? " "
            self.sum.text = data?.sum ?? " "
            self.discont.text = data?.discont ?? " "
            self.deliveryPrice.text = data?.deliveryPrice ?? " "
            self.totalSum.text = data?.totalSum ?? " "
        }
    }

}
