//
//  OrgSlideCollectionViewCellViewModel.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgSlideCollectionViewCellViewModel: OrgSlideCollectionViewCellViewModelType{
    var image: String?
    
    
    init(image: Gallery){
        self.image = image.image
    }
}
