//
//  AddImageCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AddImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addingImg: UIImageViewDesignable! //hide is default
    
    @IBOutlet weak var plusImg: UIImageViewDesignable!
    //hide if show addingImg
    
    weak var dataImage: AddingImageVIewModelType?{
        willSet(data){
            if let image = data?.image{
                addingImg.isHidden = false
                plusImg.isHidden = true
                addingImg.image = image
            }else{
                addingImg.image = nil
                addingImg.isHidden = true
                plusImg.isHidden = false
                
            }
        }
    }
}
