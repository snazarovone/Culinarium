//
//  DeliveryInfoCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfoCellViewModel: DeliveryInfoModelType, DeliveryInfoCellViewModelType{
   
    var deliveryCellType: DeliveryCellType
    
    var img: UIImage
    
    var titleInfo: String
    
    var des1Line: String?
    
    var des2Line: String?
    
    var des1Line1Col: String?
    
    var des1Line2Col: String?
    
    var des2Line1Col: String?
    
    var des2Line2Col: String?
    
    var cellType: DeliveryCellType
    
    init(deliveryInfo1Line: DeliveryInfo1Line){
        self.deliveryCellType = deliveryInfo1Line.deliveryCellType
        self.img = deliveryInfo1Line.img
        self.titleInfo = deliveryInfo1Line.title
        self.des1Line = deliveryInfo1Line.description1Line
        self.cellType = deliveryInfo1Line.deliveryCellType
    }
    
    init(deliveryInfo2Line2Col: DeliveryInfo2Line2Col){
        self.deliveryCellType = deliveryInfo2Line2Col.deliveryCellType
        self.img = deliveryInfo2Line2Col.img
        self.titleInfo = deliveryInfo2Line2Col.title
        self.cellType = deliveryInfo2Line2Col.deliveryCellType
        self.des1Line1Col = deliveryInfo2Line2Col.description1Line1Col
        self.des1Line2Col = deliveryInfo2Line2Col.description1Line2Col
        self.des2Line1Col = deliveryInfo2Line2Col.description2Line1Col
        self.des2Line2Col = deliveryInfo2Line2Col.description2Line2Col
    }
    
    init(deliveryInfo2Line: DeliveryInfo2Line){
        self.deliveryCellType = deliveryInfo2Line.deliveryCellType
        self.img = deliveryInfo2Line.img
        self.titleInfo = deliveryInfo2Line.title
        self.des1Line = deliveryInfo2Line.description1Line
        self.des2Line = deliveryInfo2Line.description2Line
        self.cellType = deliveryInfo2Line.deliveryCellType
    }
    
}
