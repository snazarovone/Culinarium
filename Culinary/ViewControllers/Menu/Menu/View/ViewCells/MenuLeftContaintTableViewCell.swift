//
//  MenuLeftContaintTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 16.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class MenuLeftContaintTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCat: UIImageViewDesignable!
    @IBOutlet weak var titleCat: UILabel!
    @IBOutlet weak var descCat: UILabel!
    
    
    weak var dataMenu: MenuCellViewModelType?{
        willSet(data){
            self.titleCat.text = data?.title
            self.descCat.text = data?.description
            self.getImage(by: data?.image, color: data?.color ?? UIColor.orange)
        }
    }
    
    private func getImage(by url: URL?, color: UIColor){
        imageCat.sd_setImage(with: url, placeholderImage: UIImage(color: color))
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
