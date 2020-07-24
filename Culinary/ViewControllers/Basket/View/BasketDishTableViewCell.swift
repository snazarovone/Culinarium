//
//  BasketDishTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 24.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit
import SwipeCellKit
import SDWebImage

class BasketDishTableViewCell: SwipeTableViewCell {
    
    @IBOutlet weak var imageDish: UIImageViewDesignable!
    @IBOutlet weak var nameDish: UILabel!
    @IBOutlet weak var portionW: UILabel!
    @IBOutlet weak var quantity: UITextFieldDesignable!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var descPriceAndQuantity: UILabel!
    
    private var idDishInBasket: Int?
    public weak var basketDelegate: BasketQuantityDelegate?
    
    weak var dataDish: BasketDishCellViewModelType?{
        willSet(data){
            getImage(by: URL(string: data?.urlImageDish ?? ""))
            nameDish.text = data?.nameDish
            portionW.text = data?.portionW
            quantity.text = data?.quantity
            price.text = data?.price
            currency.text = data?.currency
            descPriceAndQuantity.text = data?.descPriceAndQuantity
            
            idDishInBasket = data?.idItemInBasket
        }
    }
    
    private func getImage(by url: URL?){
        imageDish.sd_setImage(with: url, completed: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addQuantity(_ sender: UIButton) {
        guard let idDishInBasket = idDishInBasket, let q = quantity.text, let dq = Int(q) else {
            return
        }
        quantity.text = "\(dq+1)"
        basketDelegate?.addQuantity(at: idDishInBasket, count: dq+1)
    }
    
    @IBAction func removeQuantity(_ sender: UIButton) {
        guard let idDishInBasket = idDishInBasket, let q = quantity.text, let dq = Int(q), dq-1 >= 0 else {
            return
        }
        quantity.text = "\(dq-1)"
        basketDelegate?.removeQuantity(at: idDishInBasket, count: dq-1)
    }
}
