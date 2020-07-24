//
//  HistOrderTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class HistOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var numberOrder: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var createDate: UILabel!
    @IBOutlet weak var deliveryDate: UILabel!
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var price: UILabel!
    
    weak var historyOrderDelegate: HistoryOrderDelegate?
    private var idOrder: Int?
    
    weak var dataHist: HistOrderCellViewModelType? {
        willSet(data){
            self.bgView.backgroundColor = data?.backgroundViewColor
            
            self.numberOrder.text = data?.numberOrder
            self.position.text = data?.position
            self.createDate.text = data?.createDate
            self.payment.text = data?.payment
            self.price.text = data?.price
            self.deliveryDate.text = data?.deliveryDate ?? ""
            self.idOrder = data?.id
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func about(_ sender: UIButton) {
        historyOrderDelegate?.aboutFromHistoryOrder(at: idOrder)
    }
    
    @IBAction func repeatBtn(_ sender: UIButton) {
        historyOrderDelegate?.repearOrder(at: idOrder)
    }
}
