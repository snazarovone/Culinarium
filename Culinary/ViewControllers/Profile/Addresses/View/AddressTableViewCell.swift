//
//  AddressTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 13.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var address: UITextFieldDesignable!
    @IBOutlet weak var removeBtn: UIButton! //isHide
    @IBOutlet weak var titleAddress: UILabel!
    
    private weak var addressDelegate: AddressActionDelegate?
    private var indexPath: IndexPath?
    
    weak var dataAddress: AddressCellViewModelType?{
        willSet(data){
            addressDelegate = data?.delegateAddress
            indexPath = data?.indexPath
            
            address.text = data?.address
            titleAddress.text = data?.titleAddress
            
            if data?.isSelect ?? false{
                address.borderC = UIColor(named: "RedA4262A") ?? .red
                address.textColor = UIColor(named: "Black282A2F") ?? .black
                removeBtn.isHidden = false
            }else{
                address.borderC = UIColor(named: "Brown_B8B1AB_60") ?? .red
                address.textColor = UIColor(named: "Brown_B8B1AB_60") ?? .black
                removeBtn.isHidden = true
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

    @IBAction func remove(_ sender: UIButton) {
        if let indexPath = indexPath{
            self.addressDelegate?.removeAddress(at: indexPath)
        }
    }
}
