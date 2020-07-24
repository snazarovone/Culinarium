//
//  ProgrammLoyaltyViewController.swift
//  Culinary
//
//  Created by Sergey Nazarov on 14.01.2020.
//  Copyright © 2020 Sergey Nazarov. All rights reserved.
//

import UIKit

class ProgrammLoyaltyViewController: UIViewController {

    @IBOutlet weak var t1: UILabel!
    @IBOutlet weak var t2: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        attributedStringParagraphStyle.minimumLineHeight = 14.0

        let t1_attributedString = NSMutableAttributedString(string: "Интернет-магазин — Интернет-сайт, принадлежащий Продавцу, имеющий в сети Интернет адрес www.лгдштфкшгь.ru, на котором представлены Товары и услуги, предлагаемые Продавцом своим Участникам для оформления соответствующих заказов.")

        t1_attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Bold", size:13.0)!, range:NSMakeRange(0,16))
        t1_attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(17,210))
        t1_attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,227))
        t1_attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0), range:NSMakeRange(0,17))
        t1_attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.134, green:0.147, blue:0.17, alpha:1.0), range:NSMakeRange(17,210))
        
        t1.attributedText = t1_attributedString
        

        let t2_attributedString = NSMutableAttributedString(string: "Продавец, Организатор — Общество с ограниченной ответственностью «Кулинариум» (ОГРН 5107746007628, ИНН 7705935687, адрес: 115114 г. Москва, ул. Летниковская, дом 10, стр. 5).")

        t2_attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Bold", size:13.0)!, range:NSMakeRange(0,21))
        t2_attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Rubik-Regular", size:13.0)!, range:NSMakeRange(22,152))
        t2_attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,174))
        t2_attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.0, green:0.0, blue:0.0, alpha:1.0), range:NSMakeRange(0,22))
        t2_attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.134, green:0.147, blue:0.17, alpha:1.0), range:NSMakeRange(22,152))
        
        t2.attributedText = t2_attributedString
        
    }
    

    //MARK:- deinit
    deinit{
        print("ProgrammLoyaltyViewController is deinit")
    }

}
