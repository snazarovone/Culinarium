//
//  BallsCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BallsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var countBall: UILabel! //50
    @IBOutlet weak var titleBtn: UIButtonDesignable!
    
    weak var dataBalls: BallsCollectionCellViewModelType?{
        willSet(data){
            
        }
    }
    
    @IBAction func getBall(_ sender: UIButton) {
    }
}
