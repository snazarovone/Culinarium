//
//  BAdditTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class BAdditTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countCutleryTF: UITextFieldDesignable!
    @IBOutlet weak var countGlassTF: UITextFieldDesignable!
    
    public weak var basketExtraDelegate: BasketExtraDelegate?
   
    private var idExtraGlass: Int?
    private var idExtraCutlery: Int?
    
    weak var dataAddit: BAdditCellViewModelType?{
        willSet(data){
            countCutleryTF.text = data?.countCutlery
            countGlassTF.text = data?.countGlass
            idExtraGlass = data?.idExtraGlass
            idExtraCutlery = data?.idExtraCutlery
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

    @IBAction func minusСutlery(_ sender: UIButton) {
        guard let countStr = countCutleryTF.text, var count = Int(countStr), let idExtra = idExtraCutlery else {
            return
        }
        
        count -= 1
        if count < 0{
            count = 0
        }
        
        countCutleryTF.text = "\(count)"
        
        
        basketExtraDelegate?.changeExtraQuantity(at: idExtra , count: count)
    }
    
    @IBAction func minusGlass(_ sender: UIButton) {
        guard let countStr = countGlassTF.text, var count = Int(countStr), let idExtra = idExtraGlass else {
            return
        }
        
        count -= 1
        if count < 0{
            count = 0
        }
        
        countGlassTF.text = "\(count)"
        
        basketExtraDelegate?.changeExtraQuantity(at: idExtra, count: count)
    }
    
    @IBAction func plusСutlery(_ sender: UIButton) {
        guard let countStr = countCutleryTF.text, var count = Int(countStr), let idExtra = idExtraCutlery else {
            return
        }
        
        count += 1
        countCutleryTF.text = "\(count)"
        
        basketExtraDelegate?.changeExtraQuantity(at: idExtra, count: count)
    }
    
    @IBAction func plusGlass(_ sender: UIButton) {
        guard let countStr = countGlassTF.text, var count = Int(countStr), let idExtra = idExtraGlass else {
            return
        }
        
        count += 1
        countGlassTF.text = "\(count)"
        
        basketExtraDelegate?.changeExtraQuantity(at: idExtra, count: count)
    }
    
}
