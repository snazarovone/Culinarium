//
//  DeliveryInfo2Line2Col.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfo2Line2Col: DeliveryInfoModelType{
    
    var deliveryCellType: DeliveryCellType{
        return .description2Line2Col
    }
    
    var img: UIImage, title: String
    var description1Line1Col: String, description1Line2Col: String
    var description2Line1Col: String, description2Line2Col: String
    
    init(img: UIImage, title: String, description1Line1Col: String, description1Line2Col: String, description2Line1Col: String, description2Line2Col: String){
        self.img = img
        self.title = title
        self.description1Line1Col = description1Line1Col
        self.description1Line2Col = description1Line2Col
        self.description2Line1Col = description2Line1Col
        self.description2Line2Col = description2Line2Col
    }
}
