//
//  HitTableViewCell.swift
//  Culinary
//
//  Created by Sergey Nazarov on 04.12.2019.
//  Copyright © 2019 Sergey Nazarov. All rights reserved.
//

import UIKit

class HitTableViewCell: UITableViewCell {

    @IBOutlet weak var pictureEat: UIImageView!
    @IBOutlet weak var healthyEating: UIImageView!
    @IBOutlet weak var hit: UIImageView!
    @IBOutlet weak var countDescription: UILabel! //за 1шт и вес
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var oldPrice: UILabel! //перечеркивать
    @IBOutlet weak var nameEat: UILabel! //two Lines
    
    @IBAction func openMenu(_ sender: UIButton) {
    }
    
    @IBAction func inBasket(_ sender: UIButton) {
    }
    
}
