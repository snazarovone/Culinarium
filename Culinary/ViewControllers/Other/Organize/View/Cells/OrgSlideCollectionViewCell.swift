//
//  OrgSlideCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class OrgSlideCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageViewDesignable!
    
    weak var dataSlide: OrgSlideCollectionViewCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.image ?? ""))
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        img.sd_setImage(with: url, completed: nil)
    }
    
}
