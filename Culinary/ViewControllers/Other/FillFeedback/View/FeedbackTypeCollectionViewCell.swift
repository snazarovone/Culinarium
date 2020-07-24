//
//  FeedbackTypeCollectionViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 27.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class FeedbackTypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCell: UIViewDesignable!
    @IBOutlet weak var titleCell: UILabel!
     
     weak var dataFeedback: BMenuCollectionCellViewModelType?{
         willSet(data){
             viewCell.backgroundColor = data?.background
             viewCell.shadowColor = data?.colorShadow
             titleCell.textColor = data?.titleColor
             titleCell.text = data?.item
         }
     }
}
