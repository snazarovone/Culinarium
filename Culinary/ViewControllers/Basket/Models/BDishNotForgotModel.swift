//
//  BDishNotForgotModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BDishNotForgotModel{
    
    var img: UIImage?
    var price: String?
    var currency: String?
    var title: String?
    var count: Int?
    
    init(img: UIImage?, price: String?, currency: String?, title: String?, count: Int?) {
        self.img = img
        self.price = price
        self.currency = currency
        self.title = title
        self.count = count
    }
}
