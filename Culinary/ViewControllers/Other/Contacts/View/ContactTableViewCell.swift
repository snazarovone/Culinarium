//
//  ContactTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 09.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionContact: UILabel!
    @IBOutlet weak var mail: UIButton!
    @IBOutlet weak var phone: UIButton!
    
    weak var dataContact: ContactCellViewModelType?{
        willSet(data){
            self.name.text = data?.name
            self.descriptionContact.text = data?.description
            self.mail.setTitle(data?.mail, for: .normal)
            self.phone.setTitle(data?.phone, for: .normal)
            self.mail.isHidden = data?.isHiddenMail ?? true
            self.phone.isHidden = data?.isHiddenPhone ?? true
        }
    }
    
    weak var contactDelegate: ContactDelegate?

    @IBAction func mail_ac(_ sender: UIButton) {
        guard let mail = mail.titleLabel?.text else {
            return
        }
        contactDelegate?.send(at: mail)
    }
    
    @IBAction func phone_ac(_ sender: UIButton) {
        guard let phone = phone.titleLabel?.text else {
            return
        }
        contactDelegate?.call(at: phone)
    }
    
}
