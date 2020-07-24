//
//  DishCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 18.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class DishCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var dataDish: DishCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.urlImage ?? ""))
        }
    }
    
    private func getImage(by url: URL?){
        imageView.sd_setImage(with: url, completed: nil)
    }
}
