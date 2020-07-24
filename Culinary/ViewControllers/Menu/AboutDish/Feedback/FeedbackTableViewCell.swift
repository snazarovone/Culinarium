//
//  FeedbackTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 19.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class FeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageViewDesignable!
    @IBOutlet weak var titleFeed: UILabel!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var nameUserAndDate: UILabel!
    @IBOutlet weak var textFeed: UILabel!
    
    
    weak var dataFeedback: FeedbackCellViewModelType?{
        willSet(data){
            self.getImg(at: data?.imgUser)
            self.titleFeed.text = data?.titleFeed
            self.ratingCount.text = data?.ratingCount
            self.nameUserAndDate.text = data?.nameUserAndDate
            self.textFeed.text = data?.textFeed
            
            let rat = Int(data?.ratingCount ?? "0")!
            for (i, star) in stars.enumerated(){
                if (i+1) <= rat{
                    star.image = UIImage(named: "red_star")
                }else{
                    star.image = UIImage(named: "unselect_star")
                }
            }
        }
    }
    
    private func getImg(at url: String?){
        guard let urlStr = url, let urlImage = URL(string: urlStr) else {
            imgUser.image = UIImage(named: "ic_user")
            return
        }
        imageView?.sd_setImage(with: urlImage, placeholderImage: UIImage(named: "ic_user"))
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
