//
//  DialogTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 12.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SDWebImage

class DialogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPhoto: UIImageViewDesignable!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var timeLastMessage: UILabel!
    @IBOutlet weak var themeMessage: UILabel!
    @IBOutlet weak var timeBeginDialog: UILabel!
    @IBOutlet weak var countNewMessage: UIButton!
    
    weak var dataDialog: DialogCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.img ?? ""))
            message.text = data?.message
            timeLastMessage.text = data?.timeLastMessage
            themeMessage.text = data?.themeMessage
            timeBeginDialog.text = data?.timeBeginDialog
            countNewMessage.setTitle(data?.countNewMessage, for: .normal)
            countNewMessage.isHidden = data?.hideCountNewMessage ?? true
        }
    }

    private func getImage(by url: URL?){
        //Placeholder!!
        userPhoto.sd_setImage(with: url, completed: nil)
    }
    
}
