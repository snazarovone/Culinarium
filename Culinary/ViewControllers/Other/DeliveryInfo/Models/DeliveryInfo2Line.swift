//
//  DeliveryInfo2Line.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfo2Line: DeliveryInfoModelType{
  
    var deliveryCellType: DeliveryCellType{
        return .description2Line
    }
    
    var img: UIImage, title: String, description1Line: String, description2Line: String
      
    init(img: UIImage, title: String, description1Line: String, description2Line: String){
        self.img = img
        self.title = title
        self.description1Line = description1Line
        self.description2Line = description2Line
    }
}
