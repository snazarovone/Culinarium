//
//  CafeCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 11.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class CafeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageViewDesignable!
    @IBOutlet weak var titleCafe: UILabel!
    @IBOutlet weak var addressCafe: UILabel!
    @IBOutlet weak var distanceCafe: UIButtonDesignable!
    @IBOutlet weak var openedTime: UILabel!
    @IBOutlet weak var tagTex: UIButtonDesignable!
    
    weak var cafeData: CafeCellViewModelType?{
        willSet(data){
            titleCafe.text = data?.titleCafe
            addressCafe.text = data?.addressCafe
            distanceCafe.setTitle(data?.distanceCafe, for: .normal)
            openedTime.text = data?.openedTime
           
            getImg(at: data?.imgUrl)
            
            tagTex.isHidden = data?.nearest ?? true
        }
    }
        
    private func getImg(at url: String?){
        guard let urlStr = url, let urlImage = URL(string: urlStr) else {
            //PLACEHOLDER
            return
        }
        img?.sd_setImage(with: urlImage, placeholderImage: nil)
    }
}
