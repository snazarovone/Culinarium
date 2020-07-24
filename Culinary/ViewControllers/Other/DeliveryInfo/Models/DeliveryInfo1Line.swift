//
//  DeliveryInfo1Line.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfo1Line: DeliveryInfoModelType{
 
    var deliveryCellType: DeliveryCellType{
        return .description1Line
    }
    
    var img: UIImage, title: String, description1Line: String
      
    init(img: UIImage, title: String, description1Line: String){
        self.img = img
        self.title = title
        self.description1Line = description1Line
    }
}
