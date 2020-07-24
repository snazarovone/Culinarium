//
//  StocksCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class StocksCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var stock: UIImageView!
    
    weak var dataStock: StocksCollectionCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.imageStock ?? ""))
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        stock.sd_setImage(with: url, completed: nil)
    }
}
