//
//  OrgInfoTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 28.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class OrgInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageViewDesignable!
    @IBOutlet weak var titleInfo: UILabel!
    @IBOutlet weak var descriptionInfo: UILabel!
    @IBOutlet weak var linkInfoBtn: UIButton! //hide if empty
    
    
    weak var dataInfo: OrgInfoCellViewModelType?{
        willSet(data){
            self.img.image = data?.img
            self.titleInfo.text = data?.titleInfo
            self.descriptionInfo.text = data?.descriptionInfo
            self.linkInfoBtn.setTitle(data?.linkText, for: .normal)
            self.linkInfoBtn.isHidden = data?.hideLinkBtn ?? true
            self.descriptionInfo.isHidden = data?.hideDescriptionInfo ?? false
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
