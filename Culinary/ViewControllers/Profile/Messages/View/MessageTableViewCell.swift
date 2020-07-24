//
//  MessageTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPhoto : UIImageViewDesignable!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var fileView: UIView! //isHidden
    @IBOutlet weak var stackImages: UIStackView!
    
    weak var dataMessage: MessageCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.userPhoto ?? ""))
            
            name.text = data?.name
            timeMessage.text = data?.timeMessage
            message.text = data?.message
            fileView.isHidden = data?.isHideFileView ?? true
            
            if (data?.isHideFileView ?? true) == false, let images = data?.images{
                addDownlodImages(images: images)
            }else{
                clearStack()
            }
        }
    }
    
    private func addDownlodImages(images: [ImageDownloadViewModelType?]){
        clearStack()
        for img in images{
            let imgDownlodView = UIView.viewFromNibName(name: "ImageDownload") as! ImageDownloadView
            imgDownlodView.frame = CGRect(x: 0, y: 0, width: stackImages.frame.width, height: 60.0)
            imgDownlodView.dataImage = img
            stackImages.addArrangedSubview(imgDownlodView)
        }
    }
    
    private func clearStack(){
        for view in stackImages.arrangedSubviews{
            stackImages.removeArrangedSubview(view)
        }
    }
    
    private func getImage(by url: URL?){
        //Placeholder!!
        let placeholder = UIImage(named: "ic_profile2")
        userPhoto.sd_setImage(with: url, placeholderImage: placeholder, completed: nil)
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
