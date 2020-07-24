//
//  DeliveryInfoTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 08.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class DeliveryInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageViewDesignable!
    
    
    @IBOutlet weak var titleInfo: UILabel!
    
    
    @IBOutlet weak var des1Line: UILabel!
    
    @IBOutlet weak var des2Line: UILabel!
    
    @IBOutlet weak var dec1line1Col: UILabel!
    @IBOutlet weak var des1line2Col: UILabel!
    
    @IBOutlet weak var des2line1Col: UILabel!
    
    @IBOutlet weak var des2line2Col: UILabel!
    
    
    weak var dataDelivery: DeliveryInfoCellViewModelType? {
        willSet(data){
            guard let data = data else {return}
            
            self.titleInfo.text = data.titleInfo
            self.img.image = data.img
            
            switch data.cellType {
            case .description1Line:
                self.des1Line.text = data.des1Line
            case .description2Line:
                self.des1Line.text = data.des1Line
                self.des2Line.text = data.des2Line
            case .description2Line2Col:
                self.dec1line1Col.text = data.des1Line1Col
                self.des1line2Col.text = data.des1Line2Col
                self.des2line1Col.text = data.des2Line1Col
                self.des2line2Col.text = data.des2Line2Col
            default:
                return
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
